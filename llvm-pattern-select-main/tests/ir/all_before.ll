; ModuleID = '/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../ir/all_raw.ll'
source_filename = "/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../src/all.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f01_pos_mulpow2_expr(i32 noundef %0, i32 noundef %1) #0 {
  %3 = add nsw i32 %0, %1
  %4 = mul nsw i32 %3, 16
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f02_pos_mulpow2_loop(i32 noundef %0, i32 noundef %1) #0 {
  br label %3

3:                                                ; preds = %5, %2
  %.01 = phi i32 [ 0, %2 ], [ %8, %5 ]
  %.0 = phi i32 [ 0, %2 ], [ %9, %5 ]
  %4 = icmp slt i32 %.0, %1
  br i1 %4, label %5, label %10

5:                                                ; preds = %3
  %6 = add nsw i32 %0, %.0
  %7 = mul nsw i32 %6, 32
  %8 = add nsw i32 %.01, %7
  %9 = add nsw i32 %.0, 1
  br label %3, !llvm.loop !6

10:                                               ; preds = %3
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f03_pos_mulpow2_branch(i32 noundef %0, i32 noundef %1) #0 {
  %3 = icmp sgt i32 %1, 0
  %4 = mul nsw i32 %0, 64
  %5 = mul nsw i32 %0, 4
  %.0 = select i1 %3, i32 %4, i32 %5
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f04_pos_modpow2_expr(i32 noundef %0, i32 noundef %1) #0 {
  %3 = xor i32 %0, %1
  %4 = add i32 %3, 3
  %5 = urem i32 %4, 64
  ret i32 %5
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f05_pos_modpow2_loop(i32 noundef %0) #0 {
  br label %2

2:                                                ; preds = %4, %1
  %.01 = phi i32 [ 0, %1 ], [ %7, %4 ]
  %.0 = phi i32 [ 1, %1 ], [ %8, %4 ]
  %3 = icmp ule i32 %.0, 5
  br i1 %3, label %4, label %9

4:                                                ; preds = %2
  %5 = add i32 %0, %.0
  %6 = urem i32 %5, 128
  %7 = add i32 %.01, %6
  %8 = add i32 %.0, 1
  br label %2, !llvm.loop !8

9:                                                ; preds = %2
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f06_pos_modpow2_large(i32 noundef %0) #0 {
  %2 = add i32 %0, 7
  %3 = urem i32 %2, 1024
  ret i32 %3
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f07_pos_rotate_std(i32 noundef %0) #0 {
  %2 = shl i32 %0, 8
  %3 = lshr i32 %0, 24
  %4 = or i32 %2, %3
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f08_pos_rotate_commuted(i32 noundef %0) #0 {
  %2 = xor i32 %0, 305419896
  %3 = lshr i32 %2, 19
  %4 = shl i32 %2, 13
  %5 = or i32 %3, %4
  ret i32 %5
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f09_pos_rotate_branch(i32 noundef %0, i32 noundef %1) #0 {
  %3 = add i32 %0, 99
  %4 = icmp ne i32 %1, 0
  %5 = shl i32 %3, 7
  %6 = lshr i32 %3, 25
  %7 = or i32 %5, %6
  %.0 = select i1 %4, i32 %7, i32 %3
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f10_pos_rotate_edge1(i32 noundef %0) #0 {
  %2 = shl i32 %0, 1
  %3 = lshr i32 %0, 31
  %4 = or i32 %2, %3
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f11_pos_abs_ternary(i32 noundef %0) #0 {
  %2 = icmp slt i32 %0, 0
  %3 = sub nsw i32 0, %0
  %4 = select i1 %2, i32 %3, i32 %0
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f12_pos_abs_diff(i32 noundef %0, i32 noundef %1) #0 {
  %3 = sub nsw i32 %0, %1
  %4 = icmp slt i32 %3, 0
  %5 = sub nsw i32 0, %3
  %6 = select i1 %4, i32 %5, i32 %3
  ret i32 %6
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f13_pos_abs_loop(i32 noundef %0) #0 {
  br label %2

2:                                                ; preds = %4, %1
  %.01 = phi i32 [ 0, %1 ], [ %9, %4 ]
  %.0 = phi i32 [ -4, %1 ], [ %10, %4 ]
  %3 = icmp sle i32 %.0, 4
  br i1 %3, label %4, label %11

4:                                                ; preds = %2
  %5 = add nsw i32 %0, %.0
  %6 = icmp slt i32 %5, 0
  %7 = sub nsw i32 0, %5
  %8 = select i1 %6, i32 %7, i32 %5
  %9 = add nsw i32 %.01, %8
  %10 = add nsw i32 %.0, 1
  br label %2, !llvm.loop !9

11:                                               ; preds = %2
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f14_pos_smax_basic(i32 noundef %0, i32 noundef %1) #0 {
  %3 = icmp sgt i32 %0, %1
  %. = select i1 %3, i32 %0, i32 %1
  ret i32 %.
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f15_pos_smin_expr(i32 noundef %0, i32 noundef %1) #0 {
  %3 = add nsw i32 %0, 10
  %4 = sub nsw i32 %1, 10
  %5 = icmp slt i32 %3, %4
  %. = select i1 %5, i32 %3, i32 %4
  ret i32 %.
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f16_pos_umax_basic(i32 noundef %0, i32 noundef %1) #0 {
  %3 = icmp ugt i32 %0, %1
  %. = select i1 %3, i32 %0, i32 %1
  ret i32 %.
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f17_pos_umin_basic(i32 noundef %0, i32 noundef %1) #0 {
  %3 = icmp ult i32 %0, %1
  %. = select i1 %3, i32 %0, i32 %1
  ret i32 %.
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f18_pos_minmax_clamp(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %0, %1
  %. = select i1 %4, i32 %0, i32 %1
  %5 = icmp slt i32 %., %2
  %6 = select i1 %5, i32 %., i32 %2
  ret i32 %6
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f19_pos_bswap_std(i32 noundef %0) #0 {
  %2 = and i32 %0, -16777216
  %3 = lshr i32 %2, 24
  %4 = and i32 %0, 16711680
  %5 = lshr i32 %4, 8
  %6 = or i32 %3, %5
  %7 = and i32 %0, 65280
  %8 = shl i32 %7, 8
  %9 = or i32 %6, %8
  %10 = and i32 %0, 255
  %11 = shl i32 %10, 24
  %12 = or i32 %9, %11
  ret i32 %12
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f20_pos_bswap_permuted(i32 noundef %0) #0 {
  %2 = add i32 %0, 1
  %3 = and i32 %2, 65280
  %4 = shl i32 %3, 8
  %5 = and i32 %2, -16777216
  %6 = lshr i32 %5, 24
  %7 = or i32 %4, %6
  %8 = and i32 %2, 255
  %9 = shl i32 %8, 24
  %10 = or i32 %7, %9
  %11 = and i32 %2, 16711680
  %12 = lshr i32 %11, 8
  %13 = or i32 %10, %12
  ret i32 %13
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f21_pos_popcount_arg(i32 noundef %0) #0 {
  %2 = lshr i32 %0, 1
  %3 = and i32 %2, 1431655765
  %4 = sub i32 %0, %3
  %5 = and i32 %4, 858993459
  %6 = lshr i32 %4, 2
  %7 = and i32 %6, 858993459
  %8 = add i32 %5, %7
  %9 = lshr i32 %8, 4
  %10 = add i32 %8, %9
  %11 = and i32 %10, 252645135
  %12 = mul i32 %11, 16843009
  %13 = lshr i32 %12, 24
  ret i32 %13
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f22_pos_popcount_expr(i32 noundef %0, i32 noundef %1) #0 {
  %3 = xor i32 %0, %1
  %4 = lshr i32 %3, 1
  %5 = and i32 %4, 1431655765
  %6 = sub i32 %3, %5
  %7 = and i32 %6, 858993459
  %8 = lshr i32 %6, 2
  %9 = and i32 %8, 858993459
  %10 = add i32 %7, %9
  %11 = lshr i32 %10, 4
  %12 = add i32 %10, %11
  %13 = and i32 %12, 252645135
  %14 = mul i32 %13, 16843009
  %15 = lshr i32 %14, 24
  ret i32 %15
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f23_neg_mul_mersenne(i32 noundef %0) #0 {
  %2 = mul nsw i32 %0, 15
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f24_neg_mul_fermat(i32 noundef %0) #0 {
  %2 = mul nsw i32 %0, 17
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f25_neg_mul_negative_pow2(i32 noundef %0) #0 {
  %2 = mul nsw i32 %0, -8
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f26_neg_urem_not_pow2(i32 noundef %0) #0 {
  %2 = urem i32 %0, 24
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f27_neg_srem_signed_pow2(i32 noundef %0) #0 {
  %2 = srem i32 %0, 16
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f28_neg_srem_loop(i32 noundef %0) #0 {
  br label %2

2:                                                ; preds = %4, %1
  %.01 = phi i32 [ 0, %1 ], [ %7, %4 ]
  %.0 = phi i32 [ 0, %1 ], [ %8, %4 ]
  %3 = icmp slt i32 %.0, 4
  br i1 %3, label %4, label %9

4:                                                ; preds = %2
  %5 = sub nsw i32 %0, %.0
  %6 = srem i32 %5, 8
  %7 = add nsw i32 %.01, %6
  %8 = add nsw i32 %.0, 1
  br label %2, !llvm.loop !10

9:                                                ; preds = %2
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f29_neg_rotate_sum31(i32 noundef %0) #0 {
  %2 = shl i32 %0, 8
  %3 = lshr i32 %0, 23
  %4 = or i32 %2, %3
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f30_neg_rotate_sum33(i32 noundef %0) #0 {
  %2 = shl i32 %0, 9
  %3 = lshr i32 %0, 24
  %4 = or i32 %2, %3
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f31_neg_rotate_diff_vars(i32 noundef %0, i32 noundef %1) #0 {
  %3 = shl i32 %0, 12
  %4 = lshr i32 %1, 20
  %5 = or i32 %3, %4
  ret i32 %5
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f32_neg_rotate_xor(i32 noundef %0) #0 {
  %2 = shl i32 %0, 8
  %3 = lshr i32 %0, 24
  %4 = xor i32 %2, %3
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f33_neg_rotate_same_dir(i32 noundef %0) #0 {
  %2 = shl i32 %0, 8
  %3 = shl i32 %0, 24
  %4 = or i32 %2, %3
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f34_neg_abs_nonzero_cmp(i32 noundef %0) #0 {
  %2 = icmp slt i32 %0, 5
  %3 = sub nsw i32 0, %0
  %4 = select i1 %2, i32 %3, i32 %0
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f35_neg_abs_bitwise_not(i32 noundef %0) #0 {
  %2 = icmp slt i32 %0, 0
  %3 = xor i32 %0, -1
  %4 = select i1 %2, i32 %3, i32 %0
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f36_neg_abs_negated(i32 noundef %0) #0 {
  %2 = icmp sgt i32 %0, 0
  %3 = sub nsw i32 0, %0
  %4 = select i1 %2, i32 %3, i32 %0
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f37_neg_minmax_eq_trap(i32 noundef %0, i32 noundef %1) #0 {
  %3 = icmp eq i32 %0, %1
  %. = select i1 %3, i32 %0, i32 %1
  ret i32 %.
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f38_neg_minmax_ne_trap(i32 noundef %0, i32 noundef %1) #0 {
  %3 = icmp ne i32 %0, %1
  %. = select i1 %3, i32 %0, i32 %1
  ret i32 %.
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f39_neg_minmax_three_vars(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %0, %1
  %. = select i1 %4, i32 %0, i32 %2
  ret i32 %.
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f40_neg_minmax_wrong_cond(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %2, 0
  %. = select i1 %4, i32 %0, i32 %1
  ret i32 %.
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f41_neg_bswap_3lanes(i32 noundef %0) #0 {
  %2 = and i32 %0, 16711680
  %3 = lshr i32 %2, 8
  %4 = and i32 %0, 65280
  %5 = shl i32 %4, 8
  %6 = or i32 %3, %5
  %7 = and i32 %0, 255
  %8 = shl i32 %7, 24
  %9 = or i32 %6, %8
  ret i32 %9
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f42_neg_bswap_bad_mask(i32 noundef %0) #0 {
  %2 = and i32 %0, -16777216
  %3 = lshr i32 %2, 24
  %4 = and i32 %0, 16646144
  %5 = lshr i32 %4, 8
  %6 = or i32 %3, %5
  %7 = and i32 %0, 65280
  %8 = shl i32 %7, 8
  %9 = or i32 %6, %8
  %10 = and i32 %0, 255
  %11 = shl i32 %10, 24
  %12 = or i32 %9, %11
  ret i32 %12
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f43_neg_bswap_bad_shift(i32 noundef %0) #0 {
  %2 = and i32 %0, -16777216
  %3 = lshr i32 %2, 24
  %4 = and i32 %0, 16711680
  %5 = lshr i32 %4, 16
  %6 = or i32 %3, %5
  %7 = and i32 %0, 65280
  %8 = shl i32 %7, 8
  %9 = or i32 %6, %8
  %10 = and i32 %0, 255
  %11 = shl i32 %10, 24
  %12 = or i32 %9, %11
  ret i32 %12
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f44_neg_popcount_fake_swar(i32 noundef %0) #0 {
  %2 = add i32 %0, 42
  %3 = and i32 %2, 858993459
  %4 = lshr i32 %2, 2
  %5 = and i32 %4, 858993459
  %6 = add i32 %3, %5
  %7 = lshr i32 %6, 4
  %8 = add i32 %6, %7
  %9 = and i32 %8, 252645135
  %10 = mul i32 %9, 16843009
  %11 = lshr i32 %10, 24
  ret i32 %11
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f45_both_mul_pos_and_neg(i32 noundef %0, i32 noundef %1) #0 {
  %3 = mul nsw i32 %0, 8
  %4 = mul nsw i32 %1, 7
  %5 = add nsw i32 %3, %4
  ret i32 %5
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f46_both_mod_unsigned_and_signed(i32 noundef %0, i32 noundef %1) #0 {
  %3 = urem i32 %0, 16
  %4 = srem i32 %1, 16
  %5 = add nsw i32 %3, %4
  ret i32 %5
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f47_both_rotate_valid_and_invalid(i32 noundef %0, i32 noundef %1) #0 {
  %3 = shl i32 %0, 8
  %4 = lshr i32 %0, 24
  %5 = or i32 %3, %4
  %6 = shl i32 %1, 8
  %7 = lshr i32 %1, 22
  %8 = or i32 %6, %7
  %9 = xor i32 %5, %8
  ret i32 %9
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f48_both_abs_valid_and_invalid(i32 noundef %0, i32 noundef %1) #0 {
  %3 = icmp slt i32 %0, 0
  %4 = sub nsw i32 0, %0
  %5 = select i1 %3, i32 %4, i32 %0
  %6 = icmp slt i32 %1, 2
  %7 = sub nsw i32 0, %1
  %8 = select i1 %6, i32 %7, i32 %1
  %9 = add nsw i32 %5, %8
  ret i32 %9
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f49_both_minmax_and_3var_select(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %0, %1
  %. = select i1 %4, i32 %0, i32 %1
  %5 = icmp sgt i32 %0, %1
  %6 = select i1 %5, i32 %0, i32 %2
  %7 = add nsw i32 %., %6
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f50_both_bswap_and_partial_loop(i32 noundef %0, i32 noundef %1) #0 {
  br label %3

3:                                                ; preds = %5, %2
  %.01 = phi i32 [ 0, %2 ], [ %21, %5 ]
  %.0 = phi i32 [ 0, %2 ], [ %22, %5 ]
  %4 = icmp slt i32 %.0, %1
  br i1 %4, label %5, label %23

5:                                                ; preds = %3
  %6 = add i32 %0, %.0
  %7 = and i32 %6, -16777216
  %8 = lshr i32 %7, 24
  %9 = and i32 %6, 16711680
  %10 = lshr i32 %9, 8
  %11 = or i32 %8, %10
  %12 = and i32 %6, 65280
  %13 = shl i32 %12, 8
  %14 = or i32 %11, %13
  %15 = and i32 %6, 255
  %16 = shl i32 %15, 24
  %17 = or i32 %14, %16
  %18 = and i32 %6, 255
  %19 = shl i32 %18, 16
  %20 = add i32 %17, %19
  %21 = xor i32 %.01, %20
  %22 = add nsw i32 %.0, 1
  br label %3, !llvm.loop !11

23:                                               ; preds = %3
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f51_both_popcount_real_and_fake(i32 noundef %0, i32 noundef %1) #0 {
  %3 = lshr i32 %0, 1
  %4 = and i32 %3, 1431655765
  %5 = sub i32 %0, %4
  %6 = and i32 %5, 858993459
  %7 = lshr i32 %5, 2
  %8 = and i32 %7, 858993459
  %9 = add i32 %6, %8
  %10 = lshr i32 %9, 4
  %11 = add i32 %9, %10
  %12 = and i32 %11, 252645135
  %13 = mul i32 %12, 16843009
  %14 = lshr i32 %13, 24
  %15 = and i32 %1, 252645135
  %16 = mul i32 %15, 16843009
  %17 = lshr i32 %16, 24
  %18 = add nsw i32 %14, %17
  ret i32 %18
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f52_both_cf_diamond(i32 noundef %0, i32 noundef %1) #0 {
  %3 = icmp sgt i32 %0, 0
  br i1 %3, label %4, label %10

4:                                                ; preds = %2
  %5 = icmp slt i32 %1, 0
  %6 = sub nsw i32 0, %1
  %7 = select i1 %5, i32 %6, i32 %1
  %8 = icmp slt i32 %0, %7
  %9 = select i1 %8, i32 %0, i32 %7
  br label %15

10:                                               ; preds = %2
  %11 = icmp slt i32 %1, 1
  %12 = sub nsw i32 0, %1
  %13 = select i1 %11, i32 %12, i32 %1
  %14 = mul nsw i32 %13, 13
  br label %15

15:                                               ; preds = %10, %4
  %.0 = phi i32 [ %9, %4 ], [ %14, %10 ]
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f53_both_chained_pipeline(i32 noundef %0) #0 {
  %2 = shl i32 %0, 4
  %3 = lshr i32 %0, 28
  %4 = or i32 %2, %3
  %5 = mul i32 %4, 8
  %6 = urem i32 %5, 10
  %7 = add i32 %6, %5
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f54_both_loop_mix(i32 noundef %0, i32 noundef %1) #0 {
  br label %3

3:                                                ; preds = %5, %2
  %.01 = phi i32 [ 0, %2 ], [ %12, %5 ]
  %.0 = phi i32 [ 1, %2 ], [ %13, %5 ]
  %4 = icmp ult i32 %.0, 6
  br i1 %4, label %5, label %14

5:                                                ; preds = %3
  %6 = add i32 %0, %.0
  %7 = icmp ugt i32 %6, %1
  %. = select i1 %7, i32 %6, i32 %1
  %8 = urem i32 %., 32
  %9 = icmp eq i32 %6, %1
  %10 = select i1 %9, i32 %6, i32 99
  %11 = add i32 %8, %10
  %12 = add i32 %.01, %11
  %13 = add i32 %.0, 1
  br label %3, !llvm.loop !12

14:                                               ; preds = %3
  ret i32 %.01
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f55_both_switch_dispatcher(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = srem i32 %0, 4
  switch i32 %4, label %21 [
    i32 0, label %5
    i32 1, label %9
    i32 2, label %15
  ]

5:                                                ; preds = %3
  %6 = mul nsw i32 %1, 32
  %7 = mul nsw i32 %1, 9
  %8 = add nsw i32 %6, %7
  br label %23

9:                                                ; preds = %3
  %10 = shl i32 %2, 16
  %11 = lshr i32 %2, 16
  %12 = or i32 %10, %11
  %13 = urem i32 %2, 7
  %14 = add i32 %12, %13
  br label %23

15:                                               ; preds = %3
  %16 = icmp slt i32 %1, 0
  %17 = sub nsw i32 0, %1
  %18 = select i1 %16, i32 %17, i32 %1
  %19 = srem i32 %1, 4
  %20 = add nsw i32 %18, %19
  br label %23

21:                                               ; preds = %3
  %22 = icmp sgt i32 %1, 100
  %. = select i1 %22, i32 %1, i32 100
  br label %23

23:                                               ; preds = %21, %15, %9, %5
  %.0 = phi i32 [ %., %21 ], [ %20, %15 ], [ %14, %9 ], [ %8, %5 ]
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = call i32 @f01_pos_mulpow2_expr(i32 noundef 5, i32 noundef 3)
  %2 = sext i32 %1 to i64
  %3 = add nsw i64 0, %2
  %4 = call i32 @f02_pos_mulpow2_loop(i32 noundef 4, i32 noundef 5)
  %5 = sext i32 %4 to i64
  %6 = add nsw i64 %3, %5
  %7 = call i32 @f03_pos_mulpow2_branch(i32 noundef 7, i32 noundef 1)
  %8 = call i32 @f03_pos_mulpow2_branch(i32 noundef 7, i32 noundef -1)
  %9 = add nsw i32 %7, %8
  %10 = sext i32 %9 to i64
  %11 = add nsw i64 %6, %10
  %12 = call i32 @f04_pos_modpow2_expr(i32 noundef 100, i32 noundef 55)
  %13 = zext i32 %12 to i64
  %14 = add nsw i64 %11, %13
  %15 = call i32 @f05_pos_modpow2_loop(i32 noundef 250)
  %16 = zext i32 %15 to i64
  %17 = add nsw i64 %14, %16
  %18 = call i32 @f06_pos_modpow2_large(i32 noundef 5000)
  %19 = zext i32 %18 to i64
  %20 = add nsw i64 %17, %19
  %21 = call i32 @f07_pos_rotate_std(i32 noundef 305419896)
  %22 = zext i32 %21 to i64
  %23 = add nsw i64 %20, %22
  %24 = call i32 @f08_pos_rotate_commuted(i32 noundef -1430532899)
  %25 = zext i32 %24 to i64
  %26 = add nsw i64 %23, %25
  %27 = call i32 @f09_pos_rotate_branch(i32 noundef 252645135, i32 noundef 1)
  %28 = zext i32 %27 to i64
  %29 = add nsw i64 %26, %28
  %30 = call i32 @f10_pos_rotate_edge1(i32 noundef -2147483647)
  %31 = zext i32 %30 to i64
  %32 = add nsw i64 %29, %31
  %33 = call i32 @f11_pos_abs_ternary(i32 noundef -42)
  %34 = call i32 @f11_pos_abs_ternary(i32 noundef 42)
  %35 = add nsw i32 %33, %34
  %36 = sext i32 %35 to i64
  %37 = add nsw i64 %32, %36
  %38 = call i32 @f12_pos_abs_diff(i32 noundef 10, i32 noundef 35)
  %39 = sext i32 %38 to i64
  %40 = add nsw i64 %37, %39
  %41 = call i32 @f13_pos_abs_loop(i32 noundef 2)
  %42 = sext i32 %41 to i64
  %43 = add nsw i64 %40, %42
  %44 = call i32 @f14_pos_smax_basic(i32 noundef -10, i32 noundef 25)
  %45 = sext i32 %44 to i64
  %46 = add nsw i64 %43, %45
  %47 = call i32 @f15_pos_smin_expr(i32 noundef 30, i32 noundef 15)
  %48 = sext i32 %47 to i64
  %49 = add nsw i64 %46, %48
  %50 = call i32 @f16_pos_umax_basic(i32 noundef 100, i32 noundef 200)
  %51 = zext i32 %50 to i64
  %52 = add nsw i64 %49, %51
  %53 = call i32 @f17_pos_umin_basic(i32 noundef 100, i32 noundef 200)
  %54 = zext i32 %53 to i64
  %55 = add nsw i64 %52, %54
  %56 = call i32 @f18_pos_minmax_clamp(i32 noundef 150, i32 noundef 0, i32 noundef 100)
  %57 = sext i32 %56 to i64
  %58 = add nsw i64 %55, %57
  %59 = call i32 @f19_pos_bswap_std(i32 noundef 287454020)
  %60 = zext i32 %59 to i64
  %61 = add nsw i64 %58, %60
  %62 = call i32 @f20_pos_bswap_permuted(i32 noundef -889275714)
  %63 = zext i32 %62 to i64
  %64 = add nsw i64 %61, %63
  %65 = call i32 @f21_pos_popcount_arg(i32 noundef -252645136)
  %66 = sext i32 %65 to i64
  %67 = add nsw i64 %64, %66
  %68 = call i32 @f22_pos_popcount_expr(i32 noundef -1431677611, i32 noundef 252645135)
  %69 = sext i32 %68 to i64
  %70 = add nsw i64 %67, %69
  %71 = call i32 @f23_neg_mul_mersenne(i32 noundef 6)
  %72 = sext i32 %71 to i64
  %73 = add nsw i64 %70, %72
  %74 = call i32 @f24_neg_mul_fermat(i32 noundef 6)
  %75 = sext i32 %74 to i64
  %76 = add nsw i64 %73, %75
  %77 = call i32 @f25_neg_mul_negative_pow2(i32 noundef 9)
  %78 = sext i32 %77 to i64
  %79 = add nsw i64 %76, %78
  %80 = call i32 @f26_neg_urem_not_pow2(i32 noundef 100)
  %81 = zext i32 %80 to i64
  %82 = add nsw i64 %79, %81
  %83 = call i32 @f27_neg_srem_signed_pow2(i32 noundef -27)
  %84 = sext i32 %83 to i64
  %85 = add nsw i64 %82, %84
  %86 = call i32 @f28_neg_srem_loop(i32 noundef -15)
  %87 = sext i32 %86 to i64
  %88 = add nsw i64 %85, %87
  %89 = call i32 @f29_neg_rotate_sum31(i32 noundef 305419896)
  %90 = zext i32 %89 to i64
  %91 = add nsw i64 %88, %90
  %92 = call i32 @f30_neg_rotate_sum33(i32 noundef 305419896)
  %93 = zext i32 %92 to i64
  %94 = add nsw i64 %91, %93
  %95 = call i32 @f31_neg_rotate_diff_vars(i32 noundef 286331153, i32 noundef 572662306)
  %96 = zext i32 %95 to i64
  %97 = add nsw i64 %94, %96
  %98 = call i32 @f32_neg_rotate_xor(i32 noundef 305419896)
  %99 = zext i32 %98 to i64
  %100 = add nsw i64 %97, %99
  %101 = call i32 @f33_neg_rotate_same_dir(i32 noundef 4660)
  %102 = zext i32 %101 to i64
  %103 = add nsw i64 %100, %102
  %104 = call i32 @f34_neg_abs_nonzero_cmp(i32 noundef 3)
  %105 = sext i32 %104 to i64
  %106 = add nsw i64 %103, %105
  %107 = call i32 @f35_neg_abs_bitwise_not(i32 noundef -15)
  %108 = sext i32 %107 to i64
  %109 = add nsw i64 %106, %108
  %110 = call i32 @f36_neg_abs_negated(i32 noundef 20)
  %111 = sext i32 %110 to i64
  %112 = add nsw i64 %109, %111
  %113 = call i32 @f37_neg_minmax_eq_trap(i32 noundef 10, i32 noundef 20)
  %114 = sext i32 %113 to i64
  %115 = add nsw i64 %112, %114
  %116 = call i32 @f38_neg_minmax_ne_trap(i32 noundef 10, i32 noundef 20)
  %117 = sext i32 %116 to i64
  %118 = add nsw i64 %115, %117
  %119 = call i32 @f39_neg_minmax_three_vars(i32 noundef 10, i32 noundef 5, i32 noundef 99)
  %120 = sext i32 %119 to i64
  %121 = add nsw i64 %118, %120
  %122 = call i32 @f40_neg_minmax_wrong_cond(i32 noundef 10, i32 noundef 20, i32 noundef -1)
  %123 = sext i32 %122 to i64
  %124 = add nsw i64 %121, %123
  %125 = call i32 @f41_neg_bswap_3lanes(i32 noundef 287454020)
  %126 = zext i32 %125 to i64
  %127 = add nsw i64 %124, %126
  %128 = call i32 @f42_neg_bswap_bad_mask(i32 noundef 287454020)
  %129 = zext i32 %128 to i64
  %130 = add nsw i64 %127, %129
  %131 = call i32 @f43_neg_bswap_bad_shift(i32 noundef 287454020)
  %132 = zext i32 %131 to i64
  %133 = add nsw i64 %130, %132
  %134 = call i32 @f44_neg_popcount_fake_swar(i32 noundef 305419896)
  %135 = sext i32 %134 to i64
  %136 = add nsw i64 %133, %135
  %137 = call i32 @f45_both_mul_pos_and_neg(i32 noundef 5, i32 noundef 6)
  %138 = sext i32 %137 to i64
  %139 = add nsw i64 %136, %138
  %140 = call i32 @f46_both_mod_unsigned_and_signed(i32 noundef 45, i32 noundef -45)
  %141 = sext i32 %140 to i64
  %142 = add nsw i64 %139, %141
  %143 = call i32 @f47_both_rotate_valid_and_invalid(i32 noundef 305419896, i32 noundef -2023406815)
  %144 = zext i32 %143 to i64
  %145 = add nsw i64 %142, %144
  %146 = call i32 @f48_both_abs_valid_and_invalid(i32 noundef -30, i32 noundef 1)
  %147 = sext i32 %146 to i64
  %148 = add nsw i64 %145, %147
  %149 = call i32 @f49_both_minmax_and_3var_select(i32 noundef 15, i32 noundef 25, i32 noundef 100)
  %150 = sext i32 %149 to i64
  %151 = add nsw i64 %148, %150
  %152 = call i32 @f50_both_bswap_and_partial_loop(i32 noundef 16909060, i32 noundef 4)
  %153 = zext i32 %152 to i64
  %154 = add nsw i64 %151, %153
  %155 = call i32 @f51_both_popcount_real_and_fake(i32 noundef -16711936, i32 noundef 305419896)
  %156 = sext i32 %155 to i64
  %157 = add nsw i64 %154, %156
  %158 = call i32 @f52_both_cf_diamond(i32 noundef 12, i32 noundef -20)
  %159 = call i32 @f52_both_cf_diamond(i32 noundef -5, i32 noundef -20)
  %160 = add nsw i32 %158, %159
  %161 = sext i32 %160 to i64
  %162 = add nsw i64 %157, %161
  %163 = call i32 @f53_both_chained_pipeline(i32 noundef 16711935)
  %164 = zext i32 %163 to i64
  %165 = add nsw i64 %162, %164
  %166 = call i32 @f54_both_loop_mix(i32 noundef 10, i32 noundef 13)
  %167 = zext i32 %166 to i64
  %168 = add nsw i64 %165, %167
  %169 = call i32 @f55_both_switch_dispatcher(i32 noundef 0, i32 noundef -10, i32 noundef 50)
  %170 = sext i32 %169 to i64
  %171 = add nsw i64 %168, %170
  %172 = call i32 @f55_both_switch_dispatcher(i32 noundef 1, i32 noundef -10, i32 noundef 50)
  %173 = sext i32 %172 to i64
  %174 = add nsw i64 %171, %173
  %175 = call i32 @f55_both_switch_dispatcher(i32 noundef 2, i32 noundef -10, i32 noundef 50)
  %176 = sext i32 %175 to i64
  %177 = add nsw i64 %174, %176
  %178 = call i32 @f55_both_switch_dispatcher(i32 noundef 3, i32 noundef -10, i32 noundef 50)
  %179 = sext i32 %178 to i64
  %180 = add nsw i64 %177, %179
  %181 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %180)
  ret i32 0
}

declare i32 @printf(ptr noundef, ...) #1

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.1 (https://github.com/llvm/llvm-project.git e19b7dc36bc047b9eb72078d034596be766da350)"}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
