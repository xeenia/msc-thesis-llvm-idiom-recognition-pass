; ModuleID = '/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../src/negative_tests.c'
source_filename = "/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../src/negative_tests.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_mul_not_pow2(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = mul nsw i32 %3, 7
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_mul_zero(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = mul nsw i32 %3, 0
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_urem_not_pow2(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = urem i32 %3, 6
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_srem_pow2(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = srem i32 %3, 8
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_rotate_bad_sum(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = shl i32 %5, %6
  %8 = load i32, ptr %3, align 4
  %9 = load i32, ptr %4, align 4
  %10 = sub i32 31, %9
  %11 = lshr i32 %8, %10
  %12 = or i32 %7, %11
  ret i32 %12
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_rotate_diff_vars(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 %0, ptr %4, align 4
  store i32 %1, ptr %5, align 4
  store i32 %2, ptr %6, align 4
  %7 = load i32, ptr %4, align 4
  %8 = load i32, ptr %6, align 4
  %9 = shl i32 %7, %8
  %10 = load i32, ptr %5, align 4
  %11 = load i32, ptr %6, align 4
  %12 = sub i32 32, %11
  %13 = lshr i32 %10, %12
  %14 = or i32 %9, %13
  ret i32 %14
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_abs_wrong_pred(i32 noundef %0) #0 {
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
define dso_local i32 @negative_abs_wrong_const(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = icmp slt i32 %3, 1
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
define dso_local i32 @negative_minmax_mismatch(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
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
define dso_local i32 @negative_bswap_partial(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = and i32 %3, 255
  %5 = shl i32 %4, 24
  ret i32 %5
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  store i64 0, ptr %2, align 8
  %3 = call i32 @negative_mul_not_pow2(i32 noundef 6)
  %4 = sext i32 %3 to i64
  %5 = load i64, ptr %2, align 8
  %6 = add nsw i64 %5, %4
  store i64 %6, ptr %2, align 8
  %7 = call i32 @negative_mul_zero(i32 noundef 12)
  %8 = sext i32 %7 to i64
  %9 = load i64, ptr %2, align 8
  %10 = add nsw i64 %9, %8
  store i64 %10, ptr %2, align 8
  %11 = call i32 @negative_urem_not_pow2(i32 noundef 100)
  %12 = zext i32 %11 to i64
  %13 = load i64, ptr %2, align 8
  %14 = add nsw i64 %13, %12
  store i64 %14, ptr %2, align 8
  %15 = call i32 @negative_srem_pow2(i32 noundef -27)
  %16 = sext i32 %15 to i64
  %17 = load i64, ptr %2, align 8
  %18 = add nsw i64 %17, %16
  store i64 %18, ptr %2, align 8
  %19 = call i32 @negative_rotate_bad_sum(i32 noundef 305419896, i32 noundef 8)
  %20 = zext i32 %19 to i64
  %21 = load i64, ptr %2, align 8
  %22 = add nsw i64 %21, %20
  store i64 %22, ptr %2, align 8
  %23 = call i32 @negative_rotate_diff_vars(i32 noundef 286331153, i32 noundef 572662306, i32 noundef 8)
  %24 = zext i32 %23 to i64
  %25 = load i64, ptr %2, align 8
  %26 = add nsw i64 %25, %24
  store i64 %26, ptr %2, align 8
  %27 = call i32 @negative_abs_wrong_pred(i32 noundef -5)
  %28 = sext i32 %27 to i64
  %29 = load i64, ptr %2, align 8
  %30 = add nsw i64 %29, %28
  store i64 %30, ptr %2, align 8
  %31 = call i32 @negative_abs_wrong_const(i32 noundef -5)
  %32 = sext i32 %31 to i64
  %33 = load i64, ptr %2, align 8
  %34 = add nsw i64 %33, %32
  store i64 %34, ptr %2, align 8
  %35 = call i32 @negative_minmax_mismatch(i32 noundef 10, i32 noundef 20, i32 noundef 99)
  %36 = sext i32 %35 to i64
  %37 = load i64, ptr %2, align 8
  %38 = add nsw i64 %37, %36
  store i64 %38, ptr %2, align 8
  %39 = call i32 @negative_bswap_partial(i32 noundef 287454020)
  %40 = zext i32 %39 to i64
  %41 = load i64, ptr %2, align 8
  %42 = add nsw i64 %41, %40
  store i64 %42, ptr %2, align 8
  %43 = load i64, ptr %2, align 8
  %44 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %43)
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
