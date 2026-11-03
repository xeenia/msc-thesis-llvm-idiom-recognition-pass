# LLVM Pattern Recognition Pass (LLVM 17, C++17)

This repository contains the source code for my master's thesis project. It implements a small out-of-tree LLVM middle-end pass using the LLVM New Pass Manager. It looks for common instruction patterns in LLVM IR and replaces them with simpler operations or LLVM intrinsics.

## Recognized Idioms

The pass recognizes the following instruction patterns:

- **Multiplication by a power of two**  
  Rewrites `x * 2^n` as a left shift:

  ```text
  x * 8  ->  x << 3
  ```

- **Unsigned modulo by a power of two**  
  Rewrites `x % 2^n` as a bitwise AND with `2^n - 1`:

  ```text
  x % 32  ->  x & 31
  ```

- **Bit rotations**  
  Recognizes a pair of complementary shifts combined with OR and replaces them with the `llvm.fshl` funnel-shift intrinsic.

- **Absolute value**  
  Rewrites the conditional absolute-value idiom:

  ```text
  (x < 0) ? -x : x
  ```

  as the `llvm.abs` intrinsic.

- **Minimum and maximum**  
  Recognizes select-based min/max expressions and rewrites them using LLVM min/max intrinsics such as `llvm.smin` and `llvm.smax`.

- **Byte swap**  
  Recognizes the usual 32-bit byte-swapping sequence and replaces it with the `llvm.bswap` intrinsic.

- **Population count**  
  Recognizes the final part of a SWAR-style population-count implementation and replaces it with the `llvm.ctpop` intrinsic.

## Implementation

It uses `llvm::PatternMatch` to identify instruction patterns and `IRBuilder` to create the replacement instructions. Matched instructions are replaced using LLVM's use-replacement mechanism and runs as a function pass and is implemented as an out-of-tree LLVM plugin using the New Pass Manager.

## Tests

The repository includes positive and negative test cases. Positive tests contain idioms that should be rewritten, while negative tests cover similar-looking patterns that should remain unchanged.

LLVM FileCheck is used to verify the generated LLVM IR.
