#pragma once
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Value.h"
#include "llvm/ADT/APInt.h"
#include <optional>

struct ModPow2 {
  llvm::Value *X;
  llvm::APInt Mask;
};

struct MulPow2 {
  llvm::Value *X;
  llvm::APInt ShiftAmt;
  bool HasNUW;
  bool HasNSW;
};

struct AbsPattern {
  llvm::Value *X;
  bool IntMinIsPoison;
};

struct RotatePattern {
  llvm::Value *X;
  llvm::Value *ShAmt;
  bool IsLeft;
};

struct BSwapPattern {
  llvm::Value *X;
};

struct MinMaxPattern {
  llvm::Value *LHS;
  llvm::Value *RHS;
  llvm::Intrinsic::ID IntrinsicID;
};

struct PopCountPattern {
  llvm::Value *X;
};

bool tryMatchAndRewrite(llvm::Instruction &I);