; ModuleID = '/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../src/all.c'
source_filename = "/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../src/all.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f01_pos_mulpow2_expr(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %6 = load i32, ptr %3, align 4
  %7 = load i32, ptr %4, align 4
  %8 = add nsw i32 %6, %7
  store i32 %8, ptr %5, align 4
  %9 = load i32, ptr %5, align 4
  %10 = mul nsw i32 %9, 16
  ret i32 %10
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f02_pos_mulpow2_loop(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  store i32 0, ptr %6, align 4
  br label %7

7:                                                ; preds = %18, %2
  %8 = load i32, ptr %6, align 4
  %9 = load i32, ptr %4, align 4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %21

11:                                               ; preds = %7
  %12 = load i32, ptr %3, align 4
  %13 = load i32, ptr %6, align 4
  %14 = add nsw i32 %12, %13
  %15 = mul nsw i32 %14, 32
  %16 = load i32, ptr %5, align 4
  %17 = add nsw i32 %16, %15
  store i32 %17, ptr %5, align 4
  br label %18

18:                                               ; preds = %11
  %19 = load i32, ptr %6, align 4
  %20 = add nsw i32 %19, 1
  store i32 %20, ptr %6, align 4
  br label %7, !llvm.loop !6

21:                                               ; preds = %7
  %22 = load i32, ptr %5, align 4
  ret i32 %22
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f03_pos_mulpow2_branch(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  %6 = load i32, ptr %5, align 4
  %7 = icmp sgt i32 %6, 0
  br i1 %7, label %8, label %11

8:                                                ; preds = %2
  %9 = load i32, ptr %4, align 4
  %10 = mul nsw i32 %9, 64
  store i32 %10, ptr %3, align 4
  br label %14

11:                                               ; preds = %2
  %12 = load i32, ptr %4, align 4
  %13 = mul nsw i32 %12, 4
  store i32 %13, ptr %3, align 4
  br label %14

14:                                               ; preds = %11, %8
  %15 = load i32, ptr %3, align 4
  ret i32 %15
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f04_pos_modpow2_expr(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %6 = load i32, ptr %3, align 4
  %7 = load i32, ptr %4, align 4
  %8 = xor i32 %6, %7
  %9 = add i32 %8, 3
  store i32 %9, ptr %5, align 4
  %10 = load i32, ptr %5, align 4
  %11 = urem i32 %10, 64
  ret i32 %11
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f05_pos_modpow2_loop(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 1, ptr %4, align 4
  br label %5

5:                                                ; preds = %15, %1
  %6 = load i32, ptr %4, align 4
  %7 = icmp ule i32 %6, 5
  br i1 %7, label %8, label %18

8:                                                ; preds = %5
  %9 = load i32, ptr %2, align 4
  %10 = load i32, ptr %4, align 4
  %11 = add i32 %9, %10
  %12 = urem i32 %11, 128
  %13 = load i32, ptr %3, align 4
  %14 = add i32 %13, %12
  store i32 %14, ptr %3, align 4
  br label %15

15:                                               ; preds = %8
  %16 = load i32, ptr %4, align 4
  %17 = add i32 %16, 1
  store i32 %17, ptr %4, align 4
  br label %5, !llvm.loop !8

18:                                               ; preds = %5
  %19 = load i32, ptr %3, align 4
  ret i32 %19
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f06_pos_modpow2_large(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = add i32 %3, 7
  %5 = urem i32 %4, 1024
  ret i32 %5
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f07_pos_rotate_std(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = shl i32 %3, 8
  %5 = load i32, ptr %2, align 4
  %6 = lshr i32 %5, 24
  %7 = or i32 %4, %6
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f08_pos_rotate_commuted(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %4 = load i32, ptr %2, align 4
  %5 = xor i32 %4, 305419896
  store i32 %5, ptr %3, align 4
  %6 = load i32, ptr %3, align 4
  %7 = lshr i32 %6, 19
  %8 = load i32, ptr %3, align 4
  %9 = shl i32 %8, 13
  %10 = or i32 %7, %9
  ret i32 %10
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f09_pos_rotate_branch(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  %7 = load i32, ptr %4, align 4
  %8 = add i32 %7, 99
  store i32 %8, ptr %6, align 4
  %9 = load i32, ptr %5, align 4
  %10 = icmp ne i32 %9, 0
  br i1 %10, label %11, label %17

11:                                               ; preds = %2
  %12 = load i32, ptr %6, align 4
  %13 = shl i32 %12, 7
  %14 = load i32, ptr %6, align 4
  %15 = lshr i32 %14, 25
  %16 = or i32 %13, %15
  store i32 %16, ptr %3, align 4
  br label %19

17:                                               ; preds = %2
  %18 = load i32, ptr %6, align 4
  store i32 %18, ptr %3, align 4
  br label %19

19:                                               ; preds = %17, %11
  %20 = load i32, ptr %3, align 4
  ret i32 %20
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f10_pos_rotate_edge1(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = shl i32 %3, 1
  %5 = load i32, ptr %2, align 4
  %6 = lshr i32 %5, 31
  %7 = or i32 %4, %6
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f11_pos_abs_ternary(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp slt i32 %3, 0
  br i1 %4, label %5, label %8

5:                                                ; preds = %1
  %6 = load i32, ptr %2, align 4
  %7 = sub nsw i32 0, %6
  br label %10

8:                                                ; preds = %1
  %9 = load i32, ptr %2, align 4
  br label %10

10:                                               ; preds = %8, %5
  %11 = phi i32 [ %7, %5 ], [ %9, %8 ]
  ret i32 %11
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f12_pos_abs_diff(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %6 = load i32, ptr %3, align 4
  %7 = load i32, ptr %4, align 4
  %8 = sub nsw i32 %6, %7
  store i32 %8, ptr %5, align 4
  %9 = load i32, ptr %5, align 4
  %10 = icmp slt i32 %9, 0
  br i1 %10, label %11, label %14

11:                                               ; preds = %2
  %12 = load i32, ptr %5, align 4
  %13 = sub nsw i32 0, %12
  br label %16

14:                                               ; preds = %2
  %15 = load i32, ptr %5, align 4
  br label %16

16:                                               ; preds = %14, %11
  %17 = phi i32 [ %13, %11 ], [ %15, %14 ]
  ret i32 %17
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f13_pos_abs_loop(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 -4, ptr %4, align 4
  br label %7

7:                                                ; preds = %26, %1
  %8 = load i32, ptr %4, align 4
  %9 = icmp sle i32 %8, 4
  br i1 %9, label %10, label %29

10:                                               ; preds = %7
  %11 = load i32, ptr %2, align 4
  %12 = load i32, ptr %4, align 4
  %13 = add nsw i32 %11, %12
  store i32 %13, ptr %5, align 4
  %14 = load i32, ptr %5, align 4
  %15 = icmp slt i32 %14, 0
  br i1 %15, label %16, label %19

16:                                               ; preds = %10
  %17 = load i32, ptr %5, align 4
  %18 = sub nsw i32 0, %17
  br label %21

19:                                               ; preds = %10
  %20 = load i32, ptr %5, align 4
  br label %21

21:                                               ; preds = %19, %16
  %22 = phi i32 [ %18, %16 ], [ %20, %19 ]
  store i32 %22, ptr %6, align 4
  %23 = load i32, ptr %6, align 4
  %24 = load i32, ptr %3, align 4
  %25 = add nsw i32 %24, %23
  store i32 %25, ptr %3, align 4
  br label %26

26:                                               ; preds = %21
  %27 = load i32, ptr %4, align 4
  %28 = add nsw i32 %27, 1
  store i32 %28, ptr %4, align 4
  br label %7, !llvm.loop !9

29:                                               ; preds = %7
  %30 = load i32, ptr %3, align 4
  ret i32 %30
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f14_pos_smax_basic(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = icmp sgt i32 %5, %6
  br i1 %7, label %8, label %10

8:                                                ; preds = %2
  %9 = load i32, ptr %3, align 4
  br label %12

10:                                               ; preds = %2
  %11 = load i32, ptr %4, align 4
  br label %12

12:                                               ; preds = %10, %8
  %13 = phi i32 [ %9, %8 ], [ %11, %10 ]
  ret i32 %13
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f15_pos_smin_expr(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = add nsw i32 %7, 10
  store i32 %8, ptr %5, align 4
  %9 = load i32, ptr %4, align 4
  %10 = sub nsw i32 %9, 10
  store i32 %10, ptr %6, align 4
  %11 = load i32, ptr %5, align 4
  %12 = load i32, ptr %6, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %16

14:                                               ; preds = %2
  %15 = load i32, ptr %5, align 4
  br label %18

16:                                               ; preds = %2
  %17 = load i32, ptr %6, align 4
  br label %18

18:                                               ; preds = %16, %14
  %19 = phi i32 [ %15, %14 ], [ %17, %16 ]
  ret i32 %19
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f16_pos_umax_basic(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = icmp ugt i32 %5, %6
  br i1 %7, label %8, label %10

8:                                                ; preds = %2
  %9 = load i32, ptr %3, align 4
  br label %12

10:                                               ; preds = %2
  %11 = load i32, ptr %4, align 4
  br label %12

12:                                               ; preds = %10, %8
  %13 = phi i32 [ %9, %8 ], [ %11, %10 ]
  ret i32 %13
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f17_pos_umin_basic(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = icmp ult i32 %5, %6
  br i1 %7, label %8, label %10

8:                                                ; preds = %2
  %9 = load i32, ptr %3, align 4
  br label %12

10:                                               ; preds = %2
  %11 = load i32, ptr %4, align 4
  br label %12

12:                                               ; preds = %10, %8
  %13 = phi i32 [ %9, %8 ], [ %11, %10 ]
  ret i32 %13
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f18_pos_minmax_clamp(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %9 = load i32, ptr %4, align 4
  %10 = load i32, ptr %5, align 4
  %11 = icmp sgt i32 %9, %10
  br i1 %11, label %12, label %14

12:                                               ; preds = %3
  %13 = load i32, ptr %4, align 4
  br label %16

14:                                               ; preds = %3
  %15 = load i32, ptr %5, align 4
  br label %16

16:                                               ; preds = %14, %12
  %17 = phi i32 [ %13, %12 ], [ %15, %14 ]
  store i32 %17, ptr %7, align 4
  %18 = load i32, ptr %7, align 4
  %19 = load i32, ptr %6, align 4
  %20 = icmp slt i32 %18, %19
  br i1 %20, label %21, label %23

21:                                               ; preds = %16
  %22 = load i32, ptr %7, align 4
  br label %25

23:                                               ; preds = %16
  %24 = load i32, ptr %6, align 4
  br label %25

25:                                               ; preds = %23, %21
  %26 = phi i32 [ %22, %21 ], [ %24, %23 ]
  store i32 %26, ptr %8, align 4
  %27 = load i32, ptr %8, align 4
  ret i32 %27
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f19_pos_bswap_std(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = and i32 %3, -16777216
  %5 = lshr i32 %4, 24
  %6 = load i32, ptr %2, align 4
  %7 = and i32 %6, 16711680
  %8 = lshr i32 %7, 8
  %9 = or i32 %5, %8
  %10 = load i32, ptr %2, align 4
  %11 = and i32 %10, 65280
  %12 = shl i32 %11, 8
  %13 = or i32 %9, %12
  %14 = load i32, ptr %2, align 4
  %15 = and i32 %14, 255
  %16 = shl i32 %15, 24
  %17 = or i32 %13, %16
  ret i32 %17
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f20_pos_bswap_permuted(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %4 = load i32, ptr %2, align 4
  %5 = add i32 %4, 1
  store i32 %5, ptr %3, align 4
  %6 = load i32, ptr %3, align 4
  %7 = and i32 %6, 65280
  %8 = shl i32 %7, 8
  %9 = load i32, ptr %3, align 4
  %10 = and i32 %9, -16777216
  %11 = lshr i32 %10, 24
  %12 = or i32 %8, %11
  %13 = load i32, ptr %3, align 4
  %14 = and i32 %13, 255
  %15 = shl i32 %14, 24
  %16 = or i32 %12, %15
  %17 = load i32, ptr %3, align 4
  %18 = and i32 %17, 16711680
  %19 = lshr i32 %18, 8
  %20 = or i32 %16, %19
  ret i32 %20
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f21_pos_popcount_arg(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = load i32, ptr %2, align 4
  %5 = lshr i32 %4, 1
  %6 = and i32 %5, 1431655765
  %7 = sub i32 %3, %6
  store i32 %7, ptr %2, align 4
  %8 = load i32, ptr %2, align 4
  %9 = and i32 %8, 858993459
  %10 = load i32, ptr %2, align 4
  %11 = lshr i32 %10, 2
  %12 = and i32 %11, 858993459
  %13 = add i32 %9, %12
  store i32 %13, ptr %2, align 4
  %14 = load i32, ptr %2, align 4
  %15 = load i32, ptr %2, align 4
  %16 = lshr i32 %15, 4
  %17 = add i32 %14, %16
  %18 = and i32 %17, 252645135
  %19 = mul i32 %18, 16843009
  %20 = lshr i32 %19, 24
  ret i32 %20
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f22_pos_popcount_expr(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %6 = load i32, ptr %3, align 4
  %7 = load i32, ptr %4, align 4
  %8 = xor i32 %6, %7
  store i32 %8, ptr %5, align 4
  %9 = load i32, ptr %5, align 4
  %10 = load i32, ptr %5, align 4
  %11 = lshr i32 %10, 1
  %12 = and i32 %11, 1431655765
  %13 = sub i32 %9, %12
  store i32 %13, ptr %5, align 4
  %14 = load i32, ptr %5, align 4
  %15 = and i32 %14, 858993459
  %16 = load i32, ptr %5, align 4
  %17 = lshr i32 %16, 2
  %18 = and i32 %17, 858993459
  %19 = add i32 %15, %18
  store i32 %19, ptr %5, align 4
  %20 = load i32, ptr %5, align 4
  %21 = load i32, ptr %5, align 4
  %22 = lshr i32 %21, 4
  %23 = add i32 %20, %22
  %24 = and i32 %23, 252645135
  %25 = mul i32 %24, 16843009
  %26 = lshr i32 %25, 24
  ret i32 %26
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f23_neg_mul_mersenne(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = mul nsw i32 %3, 15
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f24_neg_mul_fermat(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = mul nsw i32 %3, 17
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f25_neg_mul_negative_pow2(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = mul nsw i32 %3, -8
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f26_neg_urem_not_pow2(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = urem i32 %3, 24
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f27_neg_srem_signed_pow2(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = srem i32 %3, 16
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f28_neg_srem_loop(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  store i32 0, ptr %3, align 4
  store i32 0, ptr %4, align 4
  br label %5

5:                                                ; preds = %15, %1
  %6 = load i32, ptr %4, align 4
  %7 = icmp slt i32 %6, 4
  br i1 %7, label %8, label %18

8:                                                ; preds = %5
  %9 = load i32, ptr %2, align 4
  %10 = load i32, ptr %4, align 4
  %11 = sub nsw i32 %9, %10
  %12 = srem i32 %11, 8
  %13 = load i32, ptr %3, align 4
  %14 = add nsw i32 %13, %12
  store i32 %14, ptr %3, align 4
  br label %15

15:                                               ; preds = %8
  %16 = load i32, ptr %4, align 4
  %17 = add nsw i32 %16, 1
  store i32 %17, ptr %4, align 4
  br label %5, !llvm.loop !10

18:                                               ; preds = %5
  %19 = load i32, ptr %3, align 4
  ret i32 %19
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f29_neg_rotate_sum31(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = shl i32 %3, 8
  %5 = load i32, ptr %2, align 4
  %6 = lshr i32 %5, 23
  %7 = or i32 %4, %6
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f30_neg_rotate_sum33(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = shl i32 %3, 9
  %5 = load i32, ptr %2, align 4
  %6 = lshr i32 %5, 24
  %7 = or i32 %4, %6
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f31_neg_rotate_diff_vars(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = shl i32 %5, 12
  %7 = load i32, ptr %4, align 4
  %8 = lshr i32 %7, 20
  %9 = or i32 %6, %8
  ret i32 %9
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f32_neg_rotate_xor(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = shl i32 %3, 8
  %5 = load i32, ptr %2, align 4
  %6 = lshr i32 %5, 24
  %7 = xor i32 %4, %6
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f33_neg_rotate_same_dir(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = shl i32 %3, 8
  %5 = load i32, ptr %2, align 4
  %6 = shl i32 %5, 24
  %7 = or i32 %4, %6
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f34_neg_abs_nonzero_cmp(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp slt i32 %3, 5
  br i1 %4, label %5, label %8

5:                                                ; preds = %1
  %6 = load i32, ptr %2, align 4
  %7 = sub nsw i32 0, %6
  br label %10

8:                                                ; preds = %1
  %9 = load i32, ptr %2, align 4
  br label %10

10:                                               ; preds = %8, %5
  %11 = phi i32 [ %7, %5 ], [ %9, %8 ]
  ret i32 %11
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f35_neg_abs_bitwise_not(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp slt i32 %3, 0
  br i1 %4, label %5, label %8

5:                                                ; preds = %1
  %6 = load i32, ptr %2, align 4
  %7 = xor i32 %6, -1
  br label %10

8:                                                ; preds = %1
  %9 = load i32, ptr %2, align 4
  br label %10

10:                                               ; preds = %8, %5
  %11 = phi i32 [ %7, %5 ], [ %9, %8 ]
  ret i32 %11
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f36_neg_abs_negated(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp sgt i32 %3, 0
  br i1 %4, label %5, label %8

5:                                                ; preds = %1
  %6 = load i32, ptr %2, align 4
  %7 = sub nsw i32 0, %6
  br label %10

8:                                                ; preds = %1
  %9 = load i32, ptr %2, align 4
  br label %10

10:                                               ; preds = %8, %5
  %11 = phi i32 [ %7, %5 ], [ %9, %8 ]
  ret i32 %11
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f37_neg_minmax_eq_trap(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = icmp eq i32 %5, %6
  br i1 %7, label %8, label %10

8:                                                ; preds = %2
  %9 = load i32, ptr %3, align 4
  br label %12

10:                                               ; preds = %2
  %11 = load i32, ptr %4, align 4
  br label %12

12:                                               ; preds = %10, %8
  %13 = phi i32 [ %9, %8 ], [ %11, %10 ]
  ret i32 %13
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f38_neg_minmax_ne_trap(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = icmp ne i32 %5, %6
  br i1 %7, label %8, label %10

8:                                                ; preds = %2
  %9 = load i32, ptr %3, align 4
  br label %12

10:                                               ; preds = %2
  %11 = load i32, ptr %4, align 4
  br label %12

12:                                               ; preds = %10, %8
  %13 = phi i32 [ %9, %8 ], [ %11, %10 ]
  ret i32 %13
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f39_neg_minmax_three_vars(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i32, ptr %4, align 4
  %8 = load i32, ptr %5, align 4
  %9 = icmp sgt i32 %7, %8
  br i1 %9, label %10, label %12

10:                                               ; preds = %3
  %11 = load i32, ptr %4, align 4
  br label %14

12:                                               ; preds = %3
  %13 = load i32, ptr %6, align 4
  br label %14

14:                                               ; preds = %12, %10
  %15 = phi i32 [ %11, %10 ], [ %13, %12 ]
  ret i32 %15
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f40_neg_minmax_wrong_cond(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i32, ptr %6, align 4
  %8 = icmp sgt i32 %7, 0
  br i1 %8, label %9, label %11

9:                                                ; preds = %3
  %10 = load i32, ptr %4, align 4
  br label %13

11:                                               ; preds = %3
  %12 = load i32, ptr %5, align 4
  br label %13

13:                                               ; preds = %11, %9
  %14 = phi i32 [ %10, %9 ], [ %12, %11 ]
  ret i32 %14
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f41_neg_bswap_3lanes(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = and i32 %3, 16711680
  %5 = lshr i32 %4, 8
  %6 = load i32, ptr %2, align 4
  %7 = and i32 %6, 65280
  %8 = shl i32 %7, 8
  %9 = or i32 %5, %8
  %10 = load i32, ptr %2, align 4
  %11 = and i32 %10, 255
  %12 = shl i32 %11, 24
  %13 = or i32 %9, %12
  ret i32 %13
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f42_neg_bswap_bad_mask(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = and i32 %3, -16777216
  %5 = lshr i32 %4, 24
  %6 = load i32, ptr %2, align 4
  %7 = and i32 %6, 16646144
  %8 = lshr i32 %7, 8
  %9 = or i32 %5, %8
  %10 = load i32, ptr %2, align 4
  %11 = and i32 %10, 65280
  %12 = shl i32 %11, 8
  %13 = or i32 %9, %12
  %14 = load i32, ptr %2, align 4
  %15 = and i32 %14, 255
  %16 = shl i32 %15, 24
  %17 = or i32 %13, %16
  ret i32 %17
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f43_neg_bswap_bad_shift(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = and i32 %3, -16777216
  %5 = lshr i32 %4, 24
  %6 = load i32, ptr %2, align 4
  %7 = and i32 %6, 16711680
  %8 = lshr i32 %7, 16
  %9 = or i32 %5, %8
  %10 = load i32, ptr %2, align 4
  %11 = and i32 %10, 65280
  %12 = shl i32 %11, 8
  %13 = or i32 %9, %12
  %14 = load i32, ptr %2, align 4
  %15 = and i32 %14, 255
  %16 = shl i32 %15, 24
  %17 = or i32 %13, %16
  ret i32 %17
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f44_neg_popcount_fake_swar(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = add i32 %3, 42
  store i32 %4, ptr %2, align 4
  %5 = load i32, ptr %2, align 4
  %6 = and i32 %5, 858993459
  %7 = load i32, ptr %2, align 4
  %8 = lshr i32 %7, 2
  %9 = and i32 %8, 858993459
  %10 = add i32 %6, %9
  store i32 %10, ptr %2, align 4
  %11 = load i32, ptr %2, align 4
  %12 = load i32, ptr %2, align 4
  %13 = lshr i32 %12, 4
  %14 = add i32 %11, %13
  %15 = and i32 %14, 252645135
  %16 = mul i32 %15, 16843009
  %17 = lshr i32 %16, 24
  ret i32 %17
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f45_both_mul_pos_and_neg(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = mul nsw i32 %7, 8
  store i32 %8, ptr %5, align 4
  %9 = load i32, ptr %4, align 4
  %10 = mul nsw i32 %9, 7
  store i32 %10, ptr %6, align 4
  %11 = load i32, ptr %5, align 4
  %12 = load i32, ptr %6, align 4
  %13 = add nsw i32 %11, %12
  ret i32 %13
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f46_both_mod_unsigned_and_signed(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = urem i32 %7, 16
  store i32 %8, ptr %5, align 4
  %9 = load i32, ptr %4, align 4
  %10 = srem i32 %9, 16
  store i32 %10, ptr %6, align 4
  %11 = load i32, ptr %5, align 4
  %12 = load i32, ptr %6, align 4
  %13 = add nsw i32 %11, %12
  ret i32 %13
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f47_both_rotate_valid_and_invalid(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = shl i32 %7, 8
  %9 = load i32, ptr %3, align 4
  %10 = lshr i32 %9, 24
  %11 = or i32 %8, %10
  store i32 %11, ptr %5, align 4
  %12 = load i32, ptr %4, align 4
  %13 = shl i32 %12, 8
  %14 = load i32, ptr %4, align 4
  %15 = lshr i32 %14, 22
  %16 = or i32 %13, %15
  store i32 %16, ptr %6, align 4
  %17 = load i32, ptr %5, align 4
  %18 = load i32, ptr %6, align 4
  %19 = xor i32 %17, %18
  ret i32 %19
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f48_both_abs_valid_and_invalid(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %7 = load i32, ptr %3, align 4
  %8 = icmp slt i32 %7, 0
  br i1 %8, label %9, label %12

9:                                                ; preds = %2
  %10 = load i32, ptr %3, align 4
  %11 = sub nsw i32 0, %10
  br label %14

12:                                               ; preds = %2
  %13 = load i32, ptr %3, align 4
  br label %14

14:                                               ; preds = %12, %9
  %15 = phi i32 [ %11, %9 ], [ %13, %12 ]
  store i32 %15, ptr %5, align 4
  %16 = load i32, ptr %4, align 4
  %17 = icmp slt i32 %16, 2
  br i1 %17, label %18, label %21

18:                                               ; preds = %14
  %19 = load i32, ptr %4, align 4
  %20 = sub nsw i32 0, %19
  br label %23

21:                                               ; preds = %14
  %22 = load i32, ptr %4, align 4
  br label %23

23:                                               ; preds = %21, %18
  %24 = phi i32 [ %20, %18 ], [ %22, %21 ]
  store i32 %24, ptr %6, align 4
  %25 = load i32, ptr %5, align 4
  %26 = load i32, ptr %6, align 4
  %27 = add nsw i32 %25, %26
  ret i32 %27
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f49_both_minmax_and_3var_select(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %9 = load i32, ptr %4, align 4
  %10 = load i32, ptr %5, align 4
  %11 = icmp sgt i32 %9, %10
  br i1 %11, label %12, label %14

12:                                               ; preds = %3
  %13 = load i32, ptr %4, align 4
  br label %16

14:                                               ; preds = %3
  %15 = load i32, ptr %5, align 4
  br label %16

16:                                               ; preds = %14, %12
  %17 = phi i32 [ %13, %12 ], [ %15, %14 ]
  store i32 %17, ptr %7, align 4
  %18 = load i32, ptr %4, align 4
  %19 = load i32, ptr %5, align 4
  %20 = icmp sgt i32 %18, %19
  br i1 %20, label %21, label %23

21:                                               ; preds = %16
  %22 = load i32, ptr %4, align 4
  br label %25

23:                                               ; preds = %16
  %24 = load i32, ptr %6, align 4
  br label %25

25:                                               ; preds = %23, %21
  %26 = phi i32 [ %22, %21 ], [ %24, %23 ]
  store i32 %26, ptr %8, align 4
  %27 = load i32, ptr %7, align 4
  %28 = load i32, ptr %8, align 4
  %29 = add nsw i32 %27, %28
  ret i32 %29
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f50_both_bswap_and_partial_loop(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  store i32 0, ptr %6, align 4
  br label %10

10:                                               ; preds = %41, %2
  %11 = load i32, ptr %6, align 4
  %12 = load i32, ptr %4, align 4
  %13 = icmp slt i32 %11, %12
  br i1 %13, label %14, label %44

14:                                               ; preds = %10
  %15 = load i32, ptr %3, align 4
  %16 = load i32, ptr %6, align 4
  %17 = add i32 %15, %16
  store i32 %17, ptr %7, align 4
  %18 = load i32, ptr %7, align 4
  %19 = and i32 %18, -16777216
  %20 = lshr i32 %19, 24
  %21 = load i32, ptr %7, align 4
  %22 = and i32 %21, 16711680
  %23 = lshr i32 %22, 8
  %24 = or i32 %20, %23
  %25 = load i32, ptr %7, align 4
  %26 = and i32 %25, 65280
  %27 = shl i32 %26, 8
  %28 = or i32 %24, %27
  %29 = load i32, ptr %7, align 4
  %30 = and i32 %29, 255
  %31 = shl i32 %30, 24
  %32 = or i32 %28, %31
  store i32 %32, ptr %8, align 4
  %33 = load i32, ptr %7, align 4
  %34 = and i32 %33, 255
  %35 = shl i32 %34, 16
  store i32 %35, ptr %9, align 4
  %36 = load i32, ptr %8, align 4
  %37 = load i32, ptr %9, align 4
  %38 = add i32 %36, %37
  %39 = load i32, ptr %5, align 4
  %40 = xor i32 %39, %38
  store i32 %40, ptr %5, align 4
  br label %41

41:                                               ; preds = %14
  %42 = load i32, ptr %6, align 4
  %43 = add nsw i32 %42, 1
  store i32 %43, ptr %6, align 4
  br label %10, !llvm.loop !11

44:                                               ; preds = %10
  %45 = load i32, ptr %5, align 4
  ret i32 %45
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f51_both_popcount_real_and_fake(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %8 = load i32, ptr %3, align 4
  store i32 %8, ptr %5, align 4
  %9 = load i32, ptr %5, align 4
  %10 = load i32, ptr %5, align 4
  %11 = lshr i32 %10, 1
  %12 = and i32 %11, 1431655765
  %13 = sub i32 %9, %12
  store i32 %13, ptr %5, align 4
  %14 = load i32, ptr %5, align 4
  %15 = and i32 %14, 858993459
  %16 = load i32, ptr %5, align 4
  %17 = lshr i32 %16, 2
  %18 = and i32 %17, 858993459
  %19 = add i32 %15, %18
  store i32 %19, ptr %5, align 4
  %20 = load i32, ptr %5, align 4
  %21 = load i32, ptr %5, align 4
  %22 = lshr i32 %21, 4
  %23 = add i32 %20, %22
  %24 = and i32 %23, 252645135
  %25 = mul i32 %24, 16843009
  %26 = lshr i32 %25, 24
  store i32 %26, ptr %6, align 4
  %27 = load i32, ptr %4, align 4
  %28 = and i32 %27, 252645135
  %29 = mul i32 %28, 16843009
  %30 = lshr i32 %29, 24
  store i32 %30, ptr %7, align 4
  %31 = load i32, ptr %6, align 4
  %32 = load i32, ptr %7, align 4
  %33 = add nsw i32 %31, %32
  ret i32 %33
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f52_both_cf_diamond(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  %8 = load i32, ptr %3, align 4
  %9 = icmp sgt i32 %8, 0
  br i1 %9, label %10, label %29

10:                                               ; preds = %2
  %11 = load i32, ptr %4, align 4
  %12 = icmp slt i32 %11, 0
  br i1 %12, label %13, label %16

13:                                               ; preds = %10
  %14 = load i32, ptr %4, align 4
  %15 = sub nsw i32 0, %14
  br label %18

16:                                               ; preds = %10
  %17 = load i32, ptr %4, align 4
  br label %18

18:                                               ; preds = %16, %13
  %19 = phi i32 [ %15, %13 ], [ %17, %16 ]
  store i32 %19, ptr %6, align 4
  %20 = load i32, ptr %3, align 4
  %21 = load i32, ptr %6, align 4
  %22 = icmp slt i32 %20, %21
  br i1 %22, label %23, label %25

23:                                               ; preds = %18
  %24 = load i32, ptr %3, align 4
  br label %27

25:                                               ; preds = %18
  %26 = load i32, ptr %6, align 4
  br label %27

27:                                               ; preds = %25, %23
  %28 = phi i32 [ %24, %23 ], [ %26, %25 ]
  store i32 %28, ptr %5, align 4
  br label %41

29:                                               ; preds = %2
  %30 = load i32, ptr %4, align 4
  %31 = icmp slt i32 %30, 1
  br i1 %31, label %32, label %35

32:                                               ; preds = %29
  %33 = load i32, ptr %4, align 4
  %34 = sub nsw i32 0, %33
  br label %37

35:                                               ; preds = %29
  %36 = load i32, ptr %4, align 4
  br label %37

37:                                               ; preds = %35, %32
  %38 = phi i32 [ %34, %32 ], [ %36, %35 ]
  store i32 %38, ptr %7, align 4
  %39 = load i32, ptr %7, align 4
  %40 = mul nsw i32 %39, 13
  store i32 %40, ptr %5, align 4
  br label %41

41:                                               ; preds = %37, %27
  %42 = load i32, ptr %5, align 4
  ret i32 %42
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f53_both_chained_pipeline(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %6 = load i32, ptr %2, align 4
  %7 = shl i32 %6, 4
  %8 = load i32, ptr %2, align 4
  %9 = lshr i32 %8, 28
  %10 = or i32 %7, %9
  store i32 %10, ptr %3, align 4
  %11 = load i32, ptr %3, align 4
  %12 = mul i32 %11, 8
  store i32 %12, ptr %4, align 4
  %13 = load i32, ptr %4, align 4
  %14 = urem i32 %13, 10
  store i32 %14, ptr %5, align 4
  %15 = load i32, ptr %5, align 4
  %16 = load i32, ptr %4, align 4
  %17 = add i32 %15, %16
  ret i32 %17
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f54_both_loop_mix(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  store i32 0, ptr %5, align 4
  store i32 1, ptr %6, align 4
  br label %11

11:                                               ; preds = %42, %2
  %12 = load i32, ptr %6, align 4
  %13 = icmp ult i32 %12, 6
  br i1 %13, label %14, label %45

14:                                               ; preds = %11
  %15 = load i32, ptr %3, align 4
  %16 = load i32, ptr %6, align 4
  %17 = add i32 %15, %16
  store i32 %17, ptr %7, align 4
  %18 = load i32, ptr %7, align 4
  %19 = load i32, ptr %4, align 4
  %20 = icmp ugt i32 %18, %19
  br i1 %20, label %21, label %23

21:                                               ; preds = %14
  %22 = load i32, ptr %7, align 4
  br label %25

23:                                               ; preds = %14
  %24 = load i32, ptr %4, align 4
  br label %25

25:                                               ; preds = %23, %21
  %26 = phi i32 [ %22, %21 ], [ %24, %23 ]
  store i32 %26, ptr %8, align 4
  %27 = load i32, ptr %8, align 4
  %28 = urem i32 %27, 32
  store i32 %28, ptr %9, align 4
  %29 = load i32, ptr %7, align 4
  %30 = load i32, ptr %4, align 4
  %31 = icmp eq i32 %29, %30
  br i1 %31, label %32, label %34

32:                                               ; preds = %25
  %33 = load i32, ptr %7, align 4
  br label %35

34:                                               ; preds = %25
  br label %35

35:                                               ; preds = %34, %32
  %36 = phi i32 [ %33, %32 ], [ 99, %34 ]
  store i32 %36, ptr %10, align 4
  %37 = load i32, ptr %9, align 4
  %38 = load i32, ptr %10, align 4
  %39 = add i32 %37, %38
  %40 = load i32, ptr %5, align 4
  %41 = add i32 %40, %39
  store i32 %41, ptr %5, align 4
  br label %42

42:                                               ; preds = %35
  %43 = load i32, ptr %6, align 4
  %44 = add i32 %43, 1
  store i32 %44, ptr %6, align 4
  br label %11, !llvm.loop !12

45:                                               ; preds = %11
  %46 = load i32, ptr %5, align 4
  ret i32 %46
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @f55_both_switch_dispatcher(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  store i32 %0, ptr %5, align 4
  store i32 %1, ptr %6, align 4
  store i32 %2, ptr %7, align 4
  %15 = load i32, ptr %5, align 4
  %16 = srem i32 %15, 4
  switch i32 %16, label %51 [
    i32 0, label %17
    i32 1, label %25
    i32 2, label %36
  ]

17:                                               ; preds = %3
  %18 = load i32, ptr %6, align 4
  %19 = mul nsw i32 %18, 32
  store i32 %19, ptr %8, align 4
  %20 = load i32, ptr %6, align 4
  %21 = mul nsw i32 %20, 9
  store i32 %21, ptr %9, align 4
  %22 = load i32, ptr %8, align 4
  %23 = load i32, ptr %9, align 4
  %24 = add nsw i32 %22, %23
  store i32 %24, ptr %4, align 4
  br label %60

25:                                               ; preds = %3
  %26 = load i32, ptr %7, align 4
  %27 = shl i32 %26, 16
  %28 = load i32, ptr %7, align 4
  %29 = lshr i32 %28, 16
  %30 = or i32 %27, %29
  store i32 %30, ptr %10, align 4
  %31 = load i32, ptr %7, align 4
  %32 = urem i32 %31, 7
  store i32 %32, ptr %11, align 4
  %33 = load i32, ptr %10, align 4
  %34 = load i32, ptr %11, align 4
  %35 = add i32 %33, %34
  store i32 %35, ptr %4, align 4
  br label %60

36:                                               ; preds = %3
  %37 = load i32, ptr %6, align 4
  %38 = icmp slt i32 %37, 0
  br i1 %38, label %39, label %42

39:                                               ; preds = %36
  %40 = load i32, ptr %6, align 4
  %41 = sub nsw i32 0, %40
  br label %44

42:                                               ; preds = %36
  %43 = load i32, ptr %6, align 4
  br label %44

44:                                               ; preds = %42, %39
  %45 = phi i32 [ %41, %39 ], [ %43, %42 ]
  store i32 %45, ptr %12, align 4
  %46 = load i32, ptr %6, align 4
  %47 = srem i32 %46, 4
  store i32 %47, ptr %13, align 4
  %48 = load i32, ptr %12, align 4
  %49 = load i32, ptr %13, align 4
  %50 = add nsw i32 %48, %49
  store i32 %50, ptr %4, align 4
  br label %60

51:                                               ; preds = %3
  %52 = load i32, ptr %6, align 4
  %53 = icmp sgt i32 %52, 100
  br i1 %53, label %54, label %56

54:                                               ; preds = %51
  %55 = load i32, ptr %6, align 4
  br label %57

56:                                               ; preds = %51
  br label %57

57:                                               ; preds = %56, %54
  %58 = phi i32 [ %55, %54 ], [ 100, %56 ]
  store i32 %58, ptr %14, align 4
  %59 = load i32, ptr %14, align 4
  store i32 %59, ptr %4, align 4
  br label %60

60:                                               ; preds = %57, %44, %25, %17
  %61 = load i32, ptr %4, align 4
  ret i32 %61
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  store i64 0, ptr %2, align 8
  %3 = call i32 @f01_pos_mulpow2_expr(i32 noundef 5, i32 noundef 3)
  %4 = sext i32 %3 to i64
  %5 = load i64, ptr %2, align 8
  %6 = add nsw i64 %5, %4
  store i64 %6, ptr %2, align 8
  %7 = call i32 @f02_pos_mulpow2_loop(i32 noundef 4, i32 noundef 5)
  %8 = sext i32 %7 to i64
  %9 = load i64, ptr %2, align 8
  %10 = add nsw i64 %9, %8
  store i64 %10, ptr %2, align 8
  %11 = call i32 @f03_pos_mulpow2_branch(i32 noundef 7, i32 noundef 1)
  %12 = call i32 @f03_pos_mulpow2_branch(i32 noundef 7, i32 noundef -1)
  %13 = add nsw i32 %11, %12
  %14 = sext i32 %13 to i64
  %15 = load i64, ptr %2, align 8
  %16 = add nsw i64 %15, %14
  store i64 %16, ptr %2, align 8
  %17 = call i32 @f04_pos_modpow2_expr(i32 noundef 100, i32 noundef 55)
  %18 = zext i32 %17 to i64
  %19 = load i64, ptr %2, align 8
  %20 = add nsw i64 %19, %18
  store i64 %20, ptr %2, align 8
  %21 = call i32 @f05_pos_modpow2_loop(i32 noundef 250)
  %22 = zext i32 %21 to i64
  %23 = load i64, ptr %2, align 8
  %24 = add nsw i64 %23, %22
  store i64 %24, ptr %2, align 8
  %25 = call i32 @f06_pos_modpow2_large(i32 noundef 5000)
  %26 = zext i32 %25 to i64
  %27 = load i64, ptr %2, align 8
  %28 = add nsw i64 %27, %26
  store i64 %28, ptr %2, align 8
  %29 = call i32 @f07_pos_rotate_std(i32 noundef 305419896)
  %30 = zext i32 %29 to i64
  %31 = load i64, ptr %2, align 8
  %32 = add nsw i64 %31, %30
  store i64 %32, ptr %2, align 8
  %33 = call i32 @f08_pos_rotate_commuted(i32 noundef -1430532899)
  %34 = zext i32 %33 to i64
  %35 = load i64, ptr %2, align 8
  %36 = add nsw i64 %35, %34
  store i64 %36, ptr %2, align 8
  %37 = call i32 @f09_pos_rotate_branch(i32 noundef 252645135, i32 noundef 1)
  %38 = zext i32 %37 to i64
  %39 = load i64, ptr %2, align 8
  %40 = add nsw i64 %39, %38
  store i64 %40, ptr %2, align 8
  %41 = call i32 @f10_pos_rotate_edge1(i32 noundef -2147483647)
  %42 = zext i32 %41 to i64
  %43 = load i64, ptr %2, align 8
  %44 = add nsw i64 %43, %42
  store i64 %44, ptr %2, align 8
  %45 = call i32 @f11_pos_abs_ternary(i32 noundef -42)
  %46 = call i32 @f11_pos_abs_ternary(i32 noundef 42)
  %47 = add nsw i32 %45, %46
  %48 = sext i32 %47 to i64
  %49 = load i64, ptr %2, align 8
  %50 = add nsw i64 %49, %48
  store i64 %50, ptr %2, align 8
  %51 = call i32 @f12_pos_abs_diff(i32 noundef 10, i32 noundef 35)
  %52 = sext i32 %51 to i64
  %53 = load i64, ptr %2, align 8
  %54 = add nsw i64 %53, %52
  store i64 %54, ptr %2, align 8
  %55 = call i32 @f13_pos_abs_loop(i32 noundef 2)
  %56 = sext i32 %55 to i64
  %57 = load i64, ptr %2, align 8
  %58 = add nsw i64 %57, %56
  store i64 %58, ptr %2, align 8
  %59 = call i32 @f14_pos_smax_basic(i32 noundef -10, i32 noundef 25)
  %60 = sext i32 %59 to i64
  %61 = load i64, ptr %2, align 8
  %62 = add nsw i64 %61, %60
  store i64 %62, ptr %2, align 8
  %63 = call i32 @f15_pos_smin_expr(i32 noundef 30, i32 noundef 15)
  %64 = sext i32 %63 to i64
  %65 = load i64, ptr %2, align 8
  %66 = add nsw i64 %65, %64
  store i64 %66, ptr %2, align 8
  %67 = call i32 @f16_pos_umax_basic(i32 noundef 100, i32 noundef 200)
  %68 = zext i32 %67 to i64
  %69 = load i64, ptr %2, align 8
  %70 = add nsw i64 %69, %68
  store i64 %70, ptr %2, align 8
  %71 = call i32 @f17_pos_umin_basic(i32 noundef 100, i32 noundef 200)
  %72 = zext i32 %71 to i64
  %73 = load i64, ptr %2, align 8
  %74 = add nsw i64 %73, %72
  store i64 %74, ptr %2, align 8
  %75 = call i32 @f18_pos_minmax_clamp(i32 noundef 150, i32 noundef 0, i32 noundef 100)
  %76 = sext i32 %75 to i64
  %77 = load i64, ptr %2, align 8
  %78 = add nsw i64 %77, %76
  store i64 %78, ptr %2, align 8
  %79 = call i32 @f19_pos_bswap_std(i32 noundef 287454020)
  %80 = zext i32 %79 to i64
  %81 = load i64, ptr %2, align 8
  %82 = add nsw i64 %81, %80
  store i64 %82, ptr %2, align 8
  %83 = call i32 @f20_pos_bswap_permuted(i32 noundef -889275714)
  %84 = zext i32 %83 to i64
  %85 = load i64, ptr %2, align 8
  %86 = add nsw i64 %85, %84
  store i64 %86, ptr %2, align 8
  %87 = call i32 @f21_pos_popcount_arg(i32 noundef -252645136)
  %88 = sext i32 %87 to i64
  %89 = load i64, ptr %2, align 8
  %90 = add nsw i64 %89, %88
  store i64 %90, ptr %2, align 8
  %91 = call i32 @f22_pos_popcount_expr(i32 noundef -1431677611, i32 noundef 252645135)
  %92 = sext i32 %91 to i64
  %93 = load i64, ptr %2, align 8
  %94 = add nsw i64 %93, %92
  store i64 %94, ptr %2, align 8
  %95 = call i32 @f23_neg_mul_mersenne(i32 noundef 6)
  %96 = sext i32 %95 to i64
  %97 = load i64, ptr %2, align 8
  %98 = add nsw i64 %97, %96
  store i64 %98, ptr %2, align 8
  %99 = call i32 @f24_neg_mul_fermat(i32 noundef 6)
  %100 = sext i32 %99 to i64
  %101 = load i64, ptr %2, align 8
  %102 = add nsw i64 %101, %100
  store i64 %102, ptr %2, align 8
  %103 = call i32 @f25_neg_mul_negative_pow2(i32 noundef 9)
  %104 = sext i32 %103 to i64
  %105 = load i64, ptr %2, align 8
  %106 = add nsw i64 %105, %104
  store i64 %106, ptr %2, align 8
  %107 = call i32 @f26_neg_urem_not_pow2(i32 noundef 100)
  %108 = zext i32 %107 to i64
  %109 = load i64, ptr %2, align 8
  %110 = add nsw i64 %109, %108
  store i64 %110, ptr %2, align 8
  %111 = call i32 @f27_neg_srem_signed_pow2(i32 noundef -27)
  %112 = sext i32 %111 to i64
  %113 = load i64, ptr %2, align 8
  %114 = add nsw i64 %113, %112
  store i64 %114, ptr %2, align 8
  %115 = call i32 @f28_neg_srem_loop(i32 noundef -15)
  %116 = sext i32 %115 to i64
  %117 = load i64, ptr %2, align 8
  %118 = add nsw i64 %117, %116
  store i64 %118, ptr %2, align 8
  %119 = call i32 @f29_neg_rotate_sum31(i32 noundef 305419896)
  %120 = zext i32 %119 to i64
  %121 = load i64, ptr %2, align 8
  %122 = add nsw i64 %121, %120
  store i64 %122, ptr %2, align 8
  %123 = call i32 @f30_neg_rotate_sum33(i32 noundef 305419896)
  %124 = zext i32 %123 to i64
  %125 = load i64, ptr %2, align 8
  %126 = add nsw i64 %125, %124
  store i64 %126, ptr %2, align 8
  %127 = call i32 @f31_neg_rotate_diff_vars(i32 noundef 286331153, i32 noundef 572662306)
  %128 = zext i32 %127 to i64
  %129 = load i64, ptr %2, align 8
  %130 = add nsw i64 %129, %128
  store i64 %130, ptr %2, align 8
  %131 = call i32 @f32_neg_rotate_xor(i32 noundef 305419896)
  %132 = zext i32 %131 to i64
  %133 = load i64, ptr %2, align 8
  %134 = add nsw i64 %133, %132
  store i64 %134, ptr %2, align 8
  %135 = call i32 @f33_neg_rotate_same_dir(i32 noundef 4660)
  %136 = zext i32 %135 to i64
  %137 = load i64, ptr %2, align 8
  %138 = add nsw i64 %137, %136
  store i64 %138, ptr %2, align 8
  %139 = call i32 @f34_neg_abs_nonzero_cmp(i32 noundef 3)
  %140 = sext i32 %139 to i64
  %141 = load i64, ptr %2, align 8
  %142 = add nsw i64 %141, %140
  store i64 %142, ptr %2, align 8
  %143 = call i32 @f35_neg_abs_bitwise_not(i32 noundef -15)
  %144 = sext i32 %143 to i64
  %145 = load i64, ptr %2, align 8
  %146 = add nsw i64 %145, %144
  store i64 %146, ptr %2, align 8
  %147 = call i32 @f36_neg_abs_negated(i32 noundef 20)
  %148 = sext i32 %147 to i64
  %149 = load i64, ptr %2, align 8
  %150 = add nsw i64 %149, %148
  store i64 %150, ptr %2, align 8
  %151 = call i32 @f37_neg_minmax_eq_trap(i32 noundef 10, i32 noundef 20)
  %152 = sext i32 %151 to i64
  %153 = load i64, ptr %2, align 8
  %154 = add nsw i64 %153, %152
  store i64 %154, ptr %2, align 8
  %155 = call i32 @f38_neg_minmax_ne_trap(i32 noundef 10, i32 noundef 20)
  %156 = sext i32 %155 to i64
  %157 = load i64, ptr %2, align 8
  %158 = add nsw i64 %157, %156
  store i64 %158, ptr %2, align 8
  %159 = call i32 @f39_neg_minmax_three_vars(i32 noundef 10, i32 noundef 5, i32 noundef 99)
  %160 = sext i32 %159 to i64
  %161 = load i64, ptr %2, align 8
  %162 = add nsw i64 %161, %160
  store i64 %162, ptr %2, align 8
  %163 = call i32 @f40_neg_minmax_wrong_cond(i32 noundef 10, i32 noundef 20, i32 noundef -1)
  %164 = sext i32 %163 to i64
  %165 = load i64, ptr %2, align 8
  %166 = add nsw i64 %165, %164
  store i64 %166, ptr %2, align 8
  %167 = call i32 @f41_neg_bswap_3lanes(i32 noundef 287454020)
  %168 = zext i32 %167 to i64
  %169 = load i64, ptr %2, align 8
  %170 = add nsw i64 %169, %168
  store i64 %170, ptr %2, align 8
  %171 = call i32 @f42_neg_bswap_bad_mask(i32 noundef 287454020)
  %172 = zext i32 %171 to i64
  %173 = load i64, ptr %2, align 8
  %174 = add nsw i64 %173, %172
  store i64 %174, ptr %2, align 8
  %175 = call i32 @f43_neg_bswap_bad_shift(i32 noundef 287454020)
  %176 = zext i32 %175 to i64
  %177 = load i64, ptr %2, align 8
  %178 = add nsw i64 %177, %176
  store i64 %178, ptr %2, align 8
  %179 = call i32 @f44_neg_popcount_fake_swar(i32 noundef 305419896)
  %180 = sext i32 %179 to i64
  %181 = load i64, ptr %2, align 8
  %182 = add nsw i64 %181, %180
  store i64 %182, ptr %2, align 8
  %183 = call i32 @f45_both_mul_pos_and_neg(i32 noundef 5, i32 noundef 6)
  %184 = sext i32 %183 to i64
  %185 = load i64, ptr %2, align 8
  %186 = add nsw i64 %185, %184
  store i64 %186, ptr %2, align 8
  %187 = call i32 @f46_both_mod_unsigned_and_signed(i32 noundef 45, i32 noundef -45)
  %188 = sext i32 %187 to i64
  %189 = load i64, ptr %2, align 8
  %190 = add nsw i64 %189, %188
  store i64 %190, ptr %2, align 8
  %191 = call i32 @f47_both_rotate_valid_and_invalid(i32 noundef 305419896, i32 noundef -2023406815)
  %192 = zext i32 %191 to i64
  %193 = load i64, ptr %2, align 8
  %194 = add nsw i64 %193, %192
  store i64 %194, ptr %2, align 8
  %195 = call i32 @f48_both_abs_valid_and_invalid(i32 noundef -30, i32 noundef 1)
  %196 = sext i32 %195 to i64
  %197 = load i64, ptr %2, align 8
  %198 = add nsw i64 %197, %196
  store i64 %198, ptr %2, align 8
  %199 = call i32 @f49_both_minmax_and_3var_select(i32 noundef 15, i32 noundef 25, i32 noundef 100)
  %200 = sext i32 %199 to i64
  %201 = load i64, ptr %2, align 8
  %202 = add nsw i64 %201, %200
  store i64 %202, ptr %2, align 8
  %203 = call i32 @f50_both_bswap_and_partial_loop(i32 noundef 16909060, i32 noundef 4)
  %204 = zext i32 %203 to i64
  %205 = load i64, ptr %2, align 8
  %206 = add nsw i64 %205, %204
  store i64 %206, ptr %2, align 8
  %207 = call i32 @f51_both_popcount_real_and_fake(i32 noundef -16711936, i32 noundef 305419896)
  %208 = sext i32 %207 to i64
  %209 = load i64, ptr %2, align 8
  %210 = add nsw i64 %209, %208
  store i64 %210, ptr %2, align 8
  %211 = call i32 @f52_both_cf_diamond(i32 noundef 12, i32 noundef -20)
  %212 = call i32 @f52_both_cf_diamond(i32 noundef -5, i32 noundef -20)
  %213 = add nsw i32 %211, %212
  %214 = sext i32 %213 to i64
  %215 = load i64, ptr %2, align 8
  %216 = add nsw i64 %215, %214
  store i64 %216, ptr %2, align 8
  %217 = call i32 @f53_both_chained_pipeline(i32 noundef 16711935)
  %218 = zext i32 %217 to i64
  %219 = load i64, ptr %2, align 8
  %220 = add nsw i64 %219, %218
  store i64 %220, ptr %2, align 8
  %221 = call i32 @f54_both_loop_mix(i32 noundef 10, i32 noundef 13)
  %222 = zext i32 %221 to i64
  %223 = load i64, ptr %2, align 8
  %224 = add nsw i64 %223, %222
  store i64 %224, ptr %2, align 8
  %225 = call i32 @f55_both_switch_dispatcher(i32 noundef 0, i32 noundef -10, i32 noundef 50)
  %226 = sext i32 %225 to i64
  %227 = load i64, ptr %2, align 8
  %228 = add nsw i64 %227, %226
  store i64 %228, ptr %2, align 8
  %229 = call i32 @f55_both_switch_dispatcher(i32 noundef 1, i32 noundef -10, i32 noundef 50)
  %230 = sext i32 %229 to i64
  %231 = load i64, ptr %2, align 8
  %232 = add nsw i64 %231, %230
  store i64 %232, ptr %2, align 8
  %233 = call i32 @f55_both_switch_dispatcher(i32 noundef 2, i32 noundef -10, i32 noundef 50)
  %234 = sext i32 %233 to i64
  %235 = load i64, ptr %2, align 8
  %236 = add nsw i64 %235, %234
  store i64 %236, ptr %2, align 8
  %237 = call i32 @f55_both_switch_dispatcher(i32 noundef 3, i32 noundef -10, i32 noundef 50)
  %238 = sext i32 %237 to i64
  %239 = load i64, ptr %2, align 8
  %240 = add nsw i64 %239, %238
  store i64 %240, ptr %2, align 8
  %241 = load i64, ptr %2, align 8
  %242 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %241)
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
