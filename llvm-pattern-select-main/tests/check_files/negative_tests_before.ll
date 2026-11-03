; ============================================================================
; Negative Regression Suite (Ensures decoys are NEVER miscompiled)
; ============================================================================

; CHECK-LABEL: define {{.*}}@negative_mul_not_pow2(
; CHECK-NOT: shl
; CHECK:     mul nsw i32 {{%.*}}, 7

; CHECK-LABEL: define {{.*}}@negative_mul_zero(
; CHECK-NOT: shl
; CHECK:     mul nsw i32 {{%.*}}, 0

; CHECK-LABEL: define {{.*}}@negative_urem_not_pow2(
; CHECK-NOT: and i32
; CHECK:     urem i32 {{%.*}}, 6

; CHECK-LABEL: define {{.*}}@negative_srem_pow2(
; CHECK-NOT: and i32
; CHECK:     srem i32 {{%.*}}, 8

; CHECK-LABEL: define {{.*}}@negative_rotate_bad_sum(
; CHECK-NOT: @llvm.fshl
; CHECK:     or i32

; CHECK-LABEL: define {{.*}}@negative_rotate_diff_vars(
; CHECK-NOT: @llvm.fshl
; CHECK:     or i32

; CHECK-LABEL: define {{.*}}@negative_abs_wrong_pred(
; CHECK-NOT: @llvm.abs
; CHECK:     select i1 {{%.*}}, i32 {{%.*}}, i32 {{%.*}}

; CHECK-LABEL: define {{.*}}@negative_abs_wrong_const(
; CHECK-NOT: @llvm.abs
; CHECK:     select i1 {{%.*}}, i32 {{%.*}}, i32 {{%.*}}

; CHECK-LABEL: define {{.*}}@negative_minmax_mismatch(
; CHECK-NOT: @llvm.smax
; CHECK-NOT: @llvm.smin
; CHECK:     select i1 {{%.*}}, i32 {{%.*}}, i32 {{%.*}}

; CHECK-LABEL: define {{.*}}@negative_bswap_partial(
; CHECK-NOT: @llvm.bswap
; CHECK:     shl i32 {{%.*}}, 24

; ModuleID = '/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../ir/negative_tests_raw.ll'
source_filename = "/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../src/negative_tests.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_mul_not_pow2(i32 noundef %0) #0 {
  %2 = mul nsw i32 %0, 7
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_mul_zero(i32 noundef %0) #0 {
  %2 = mul nsw i32 %0, 0
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_urem_not_pow2(i32 noundef %0) #0 {
  %2 = urem i32 %0, 6
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_srem_pow2(i32 noundef %0) #0 {
  %2 = srem i32 %0, 8
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_rotate_bad_sum(i32 noundef %0, i32 noundef %1) #0 {
  %3 = shl i32 %0, %1
  %4 = sub i32 31, %1
  %5 = lshr i32 %0, %4
  %6 = or i32 %3, %5
  ret i32 %6
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_rotate_diff_vars(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = shl i32 %0, %2
  %5 = sub i32 32, %2
  %6 = lshr i32 %1, %5
  %7 = or i32 %4, %6
  ret i32 %7
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_abs_wrong_pred(i32 noundef %0) #0 {
  %2 = icmp sgt i32 %0, 0
  %3 = sub nsw i32 0, %0
  %4 = select i1 %2, i32 %3, i32 %0
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_abs_wrong_const(i32 noundef %0) #0 {
  %2 = icmp slt i32 %0, 1
  %3 = sub nsw i32 0, %0
  %4 = select i1 %2, i32 %3, i32 %0
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_minmax_mismatch(i32 noundef %0, i32 noundef %1, i32 noundef %2) #0 {
  %4 = icmp sgt i32 %0, %1
  %. = select i1 %4, i32 %0, i32 %2
  ret i32 %.
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @negative_bswap_partial(i32 noundef %0) #0 {
  %2 = and i32 %0, 255
  %3 = shl i32 %2, 24
  ret i32 %3
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @main() #0 {
  %1 = call i32 @negative_mul_not_pow2(i32 noundef 6)
  %2 = sext i32 %1 to i64
  %3 = add nsw i64 0, %2
  %4 = call i32 @negative_mul_zero(i32 noundef 12)
  %5 = sext i32 %4 to i64
  %6 = add nsw i64 %3, %5
  %7 = call i32 @negative_urem_not_pow2(i32 noundef 100)
  %8 = zext i32 %7 to i64
  %9 = add nsw i64 %6, %8
  %10 = call i32 @negative_srem_pow2(i32 noundef -27)
  %11 = sext i32 %10 to i64
  %12 = add nsw i64 %9, %11
  %13 = call i32 @negative_rotate_bad_sum(i32 noundef 305419896, i32 noundef 8)
  %14 = zext i32 %13 to i64
  %15 = add nsw i64 %12, %14
  %16 = call i32 @negative_rotate_diff_vars(i32 noundef 286331153, i32 noundef 572662306, i32 noundef 8)
  %17 = zext i32 %16 to i64
  %18 = add nsw i64 %15, %17
  %19 = call i32 @negative_abs_wrong_pred(i32 noundef -5)
  %20 = sext i32 %19 to i64
  %21 = add nsw i64 %18, %20
  %22 = call i32 @negative_abs_wrong_const(i32 noundef -5)
  %23 = sext i32 %22 to i64
  %24 = add nsw i64 %21, %23
  %25 = call i32 @negative_minmax_mismatch(i32 noundef 10, i32 noundef 20, i32 noundef 99)
  %26 = sext i32 %25 to i64
  %27 = add nsw i64 %24, %26
  %28 = call i32 @negative_bswap_partial(i32 noundef 287454020)
  %29 = zext i32 %28 to i64
  %30 = add nsw i64 %27, %29
  %31 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %30)
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
