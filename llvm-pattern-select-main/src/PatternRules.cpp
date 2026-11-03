#include "PatternRules.h"
#include "llvm/ADT/Statistic.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Intrinsics.h"
#include "llvm/IR/PatternMatch.h"
#include "llvm/Transforms/Utils/Local.h"

#define DEBUG_TYPE "pattern-select"

STATISTIC(NumRotates,  "Number of rotates optimized");
STATISTIC(NumMulPow2,  "Number of mul-pow2 optimized");
STATISTIC(NumModPow2,  "Number of mod-pow2 optimized");
STATISTIC(NumBSwap,    "Number of byte-swaps optimized");
STATISTIC(NumPopCount, "Number of popcounts optimized");
STATISTIC(NumAbs,      "Number of abs optimized");
STATISTIC(NumMinMax,   "Number of min/max optimized");

using namespace llvm;
using namespace llvm::PatternMatch;

// Helper to erase the replaced instruction and prune dead intermediate operands
static void replaceAndCleanup(Instruction &I, Value *NewVal) {
  SmallVector<Value *, 4> Ops(I.operands());
  I.replaceAllUsesWith(NewVal);
  I.eraseFromParent();
  for (Value *Op : Ops) {
    if (Instruction *OpInst = dyn_cast<Instruction>(Op))
      RecursivelyDeleteTriviallyDeadInstructions(OpInst);
  }
}

// ============================================================================
// MATCHERS
// ============================================================================

static std::optional<ModPow2> matchModPow2(Instruction &I) {
  Value *X = nullptr;
  const APInt *C = nullptr;
  if (!match(&I, m_URem(m_Value(X), m_APInt(C))))
    return std::nullopt;

  if (!C->isPowerOf2())
    return std::nullopt;

  return ModPow2{X, *C - 1};
}

static std::optional<MulPow2> matchMulPow2(Instruction &I) {
  Value *X = nullptr;
  const APInt *C = nullptr;
  if (!match(&I, m_Mul(m_Value(X), m_APInt(C))))
    return std::nullopt;

  if (!C->isPowerOf2())
    return std::nullopt;

  APInt ShiftAmt(C->getBitWidth(), C->countr_zero());
  return MulPow2{X, ShiftAmt, I.hasNoUnsignedWrap(), I.hasNoSignedWrap()};
}

static std::optional<AbsPattern> matchAbs(Instruction &I) {
  Value *Cond = nullptr, *TrueVal = nullptr, *FalseVal = nullptr;
  if (!match(&I, m_Select(m_Value(Cond), m_Value(TrueVal), m_Value(FalseVal))))
    return std::nullopt;

  ICmpInst::Predicate Pred;
  Value *X = nullptr;
  if (!match(Cond, m_ICmp(Pred, m_Value(X), m_Zero())))
    return std::nullopt;

  // Matches: (X < 0) ? -X : X  or  (X <= -1)
  if (Pred == ICmpInst::ICMP_SLT) {
    if (match(TrueVal, m_Neg(m_Specific(X))) && match(FalseVal, m_Specific(X))) {
      bool IsNSW = cast<Instruction>(TrueVal)->hasNoSignedWrap();
      return AbsPattern{X, IsNSW};
    }
  }
  // Matches: (X > 0) ? X : -X  or  (X >= 0) ? X : -X
  else if (Pred == ICmpInst::ICMP_SGT || Pred == ICmpInst::ICMP_SGE) {
    if (match(TrueVal, m_Specific(X)) && match(FalseVal, m_Neg(m_Specific(X)))) {
      bool IsNSW = cast<Instruction>(FalseVal)->hasNoSignedWrap();
      return AbsPattern{X, IsNSW};
    }
  }
  return std::nullopt;
}

static std::optional<RotatePattern> matchRotate(Instruction &I) {
  Value *X = nullptr, *Y = nullptr;
  ConstantInt *C1 = nullptr, *C2 = nullptr;

  // Case A: Constant shift amounts (commutative OR)
  if (match(&I, m_c_Or(m_Shl(m_Value(X), m_ConstantInt(C1)),
                       m_LShr(m_Value(Y), m_ConstantInt(C2))))) {
    if (!isa<Constant>(X) && X == Y) {
      uint32_t BW = X->getType()->getScalarSizeInBits();
      uint64_t S1 = C1->getZExtValue();
      uint64_t S2 = C2->getZExtValue();
      if (S1 > 0 && S2 > 0 && S1 + S2 == BW)
        return RotatePattern{X, C1, true};
    }
  }

  // Case B: Variable shift amount: (x << s) | (x >> (BW - s))
  Value *S = nullptr;
  const APInt *SubConst = nullptr;
  if (match(&I, m_c_Or(m_Shl(m_Value(X), m_Value(S)),
                       m_LShr(m_Value(Y), m_Sub(m_APInt(SubConst), m_Specific(S)))))) {
    uint32_t BW = X->getType()->getScalarSizeInBits();
    if (X == Y && *SubConst == BW)
      return RotatePattern{X, S, true};
  }

  return std::nullopt;
}

static std::optional<BSwapPattern> matchBSwap(Instruction &I) {
  if (!I.getType()->isIntegerTy(32))
    return std::nullopt;

  Value *OpA = nullptr, *OpB = nullptr, *OpC = nullptr, *OpD = nullptr;
  if (!match(&I, m_c_Or(m_c_Or(m_c_Or(m_Value(OpA), m_Value(OpB)), m_Value(OpC)), m_Value(OpD))))
    return std::nullopt;

  auto matchBytePart = [](Value *V, Value *&Root, uint64_t Mask, uint64_t Shift, bool isLeft) -> bool {
    Value *X = nullptr;
    ConstantInt *CMask = nullptr, *CShift = nullptr;
    bool Matched = isLeft
        ? match(V, m_Shl(m_And(m_Value(X), m_ConstantInt(CMask)), m_ConstantInt(CShift)))
        : match(V, m_LShr(m_And(m_Value(X), m_ConstantInt(CMask)), m_ConstantInt(CShift)));
    if (!Matched || CMask->getZExtValue() != Mask || CShift->getZExtValue() != Shift)
      return false;
    if (!Root)
      Root = X;
    return Root == X;
  };

  Value *Root = nullptr;
  bool found[4] = {false, false, false, false};
  for (Value *Part : {OpA, OpB, OpC, OpD}) {
    if (matchBytePart(Part, Root, 0xFF000000, 24, false)) { found[3] = true; continue; }
    if (matchBytePart(Part, Root, 0x00FF0000, 8, false))  { found[2] = true; continue; }
    if (matchBytePart(Part, Root, 0x0000FF00, 8, true))   { found[1] = true; continue; }
    if (matchBytePart(Part, Root, 0x000000FF, 24, true))  { found[0] = true; continue; }
  }

  if (found[0] && found[1] && found[2] && found[3] && Root)
    return BSwapPattern{Root};
  return std::nullopt;
}

static std::optional<MinMaxPattern> matchMinMax(Instruction &I) {
  Value *Cond = nullptr, *TrueVal = nullptr, *FalseVal = nullptr;
  if (!match(&I, m_Select(m_Value(Cond), m_Value(TrueVal), m_Value(FalseVal))))
    return std::nullopt;

  ICmpInst::Predicate Pred;
  Value *CmpLHS = nullptr, *CmpRHS = nullptr;
  if (!match(Cond, m_ICmp(Pred, m_Value(CmpLHS), m_Value(CmpRHS))))
    return std::nullopt;

  // If ICmp has (FalseVal, TrueVal), swap predicate to normalize to (TrueVal, FalseVal)
  if (CmpLHS == FalseVal && CmpRHS == TrueVal) {
    Pred = ICmpInst::getSwappedPredicate(Pred);
  } else if (!(CmpLHS == TrueVal && CmpRHS == FalseVal)) {
    return std::nullopt;
  }

  switch (Pred) {
  case ICmpInst::ICMP_SGT:
  case ICmpInst::ICMP_SGE:
    return MinMaxPattern{TrueVal, FalseVal, Intrinsic::smax};
  case ICmpInst::ICMP_SLT:
  case ICmpInst::ICMP_SLE:
    return MinMaxPattern{TrueVal, FalseVal, Intrinsic::smin};
  case ICmpInst::ICMP_UGT:
  case ICmpInst::ICMP_UGE:
    return MinMaxPattern{TrueVal, FalseVal, Intrinsic::umax};
  case ICmpInst::ICMP_ULT:
  case ICmpInst::ICMP_ULE:
    return MinMaxPattern{TrueVal, FalseVal, Intrinsic::umin};
  default:
    return std::nullopt;
  }
}

static std::optional<PopCountPattern> matchPopCount(Instruction &I) {
  Value *Op = nullptr;
  if (!match(&I, m_LShr(m_Mul(m_Value(Op), m_SpecificInt(0x01010101)), m_SpecificInt(24))))
    return std::nullopt;

  Value *V = nullptr;
  if (!match(Op, m_And(m_Value(V), m_SpecificInt(0x0F0F0F0F))))
    return std::nullopt;

  Value *S2 = nullptr;
  if (!match(V, m_c_Add(m_Value(S2), m_LShr(m_Deferred(S2), m_SpecificInt(4)))))
    return std::nullopt;

  Value *S1 = nullptr;
  if (!match(S2, m_c_Add(m_And(m_Value(S1), m_SpecificInt(0x33333333)),
                         m_And(m_LShr(m_Deferred(S1), m_SpecificInt(2)), m_SpecificInt(0x33333333)))))
    return std::nullopt;

  Value *X = nullptr;
  if (match(S1, m_Sub(m_Value(X), m_And(m_LShr(m_Deferred(X), m_SpecificInt(1)), m_SpecificInt(0x55555555)))))
    return PopCountPattern{X};

  return std::nullopt;
}

// ============================================================================
// REWRITERS
// ============================================================================

static bool rewriteModPow2(Instruction &I, const ModPow2 &P) {
  IRBuilder<> B(&I);
  Value *And = B.CreateAnd(P.X, ConstantInt::get(I.getType(), P.Mask));
  NumModPow2++;
  replaceAndCleanup(I, And);
  return true;
}

static bool rewriteMulPow2(Instruction &I, const MulPow2 &P) {
  IRBuilder<> B(&I);
  Value *Shl = B.CreateShl(P.X, ConstantInt::get(I.getType(), P.ShiftAmt), "", P.HasNUW, P.HasNSW);
  NumMulPow2++;
  replaceAndCleanup(I, Shl);
  return true;
}

static bool rewriteAbs(Instruction &I, const AbsPattern &P) {
  IRBuilder<> B(&I);
  CallInst *Abs = B.CreateIntrinsic(Intrinsic::abs, {I.getType()}, {P.X, B.getInt1(P.IntMinIsPoison)});
  NumAbs++;
  replaceAndCleanup(I, Abs);
  return true;
}

static bool rewriteRotate(Instruction &I, const RotatePattern &P) {
  IRBuilder<> B(&I);
  Intrinsic::ID IID = P.IsLeft ? Intrinsic::fshl : Intrinsic::fshr;
  CallInst *Rot = B.CreateIntrinsic(IID, {I.getType()}, {P.X, P.X, P.ShAmt});
  NumRotates++;
  replaceAndCleanup(I, Rot);
  return true;
}

static bool rewriteBSwap(Instruction &I, const BSwapPattern &P) {
  IRBuilder<> B(&I);
  CallInst *Swap = B.CreateIntrinsic(Intrinsic::bswap, {I.getType()}, {P.X});
  NumBSwap++;
  replaceAndCleanup(I, Swap);
  return true;
}

static bool rewriteMinMax(Instruction &I, const MinMaxPattern &P) {
  IRBuilder<> B(&I);
  CallInst *Res = B.CreateIntrinsic(P.IntrinsicID, {I.getType()}, {P.LHS, P.RHS});
  NumMinMax++;
  replaceAndCleanup(I, Res);
  return true;
}

static bool rewritePopCount(Instruction &I, const PopCountPattern &P) {
  IRBuilder<> B(&I);
  CallInst *Pop = B.CreateIntrinsic(Intrinsic::ctpop, {I.getType()}, {P.X});
  NumPopCount++;
  replaceAndCleanup(I, Pop);
  return true;
}

// ============================================================================
// DISPATCHER
// ============================================================================

bool tryMatchAndRewrite(Instruction &I) {
  if (auto M = matchModPow2(I))  return rewriteModPow2(I, *M);
  if (auto M = matchMulPow2(I))  return rewriteMulPow2(I, *M);
  if (auto A = matchAbs(I))      return rewriteAbs(I, *A);
  if (auto R = matchRotate(I))   return rewriteRotate(I, *R);
  if (auto M = matchMinMax(I))   return rewriteMinMax(I, *M);
  if (auto B = matchBSwap(I))    return rewriteBSwap(I, *B);
  if (auto P = matchPopCount(I)) return rewritePopCount(I, *P);
  return false;
}