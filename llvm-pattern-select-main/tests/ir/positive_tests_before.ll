; ModuleID = '/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../ir/positive_tests_raw.ll'
source_filename = "/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../src/positive_tests.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @times8(i32 noundef %0) #0 {
  %2 = mul nsw i32 %0, 8
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @mod32(i32 noundef %0) #0 {
  %2 = urem i32 %0, 32
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_rotate(i32 noundef %0) #0 {
  %2 = shl i32 %0, 8
  %3 = lshr i32 %0, 24
  %4 = or i32 %2, %3
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_abs(i32 noundef %0) #0 {
  %2 = icmp slt i32 %0, 0
  %3 = sub nsw i32 0, %0
  %.0 = select i1 %2, i32 %3, i32 %0
  ret i32 %.0
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_max(i32 noundef %0, i32 noundef %1) #0 {
  %3 = icmp sgt i32 %0, %1
  %. = select i1 %3, i32 %0, i32 %1
  ret i32 %.
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_min(i32 noundef %0, i32 noundef %1) #0 {
  %3 = icmp slt i32 %0, %1
  %. = select i1 %3, i32 %0, i32 %1
  ret i32 %.
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_bswap(i32 noundef %0) #0 {
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
define dso_local i32 @test_popcount_logic(i32 noundef %0) #0 {
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
define dso_local i32 @main() #0 {
  %1 = call i32 @times8(i32 noundef 5)
  %2 = sext i32 %1 to i64
  %3 = add nsw i64 0, %2
  %4 = call i32 @mod32(i32 noundef 45)
  %5 = zext i32 %4 to i64
  %6 = add nsw i64 %3, %5
  %7 = call i32 @test_rotate(i32 noundef 305419896)
  %8 = zext i32 %7 to i64
  %9 = add nsw i64 %6, %8
  %10 = call i32 @test_abs(i32 noundef -15)
  %11 = sext i32 %10 to i64
  %12 = add nsw i64 %9, %11
  %13 = call i32 @test_max(i32 noundef 10, i32 noundef 25)
  %14 = sext i32 %13 to i64
  %15 = add nsw i64 %12, %14
  %16 = call i32 @test_min(i32 noundef 10, i32 noundef 25)
  %17 = sext i32 %16 to i64
  %18 = add nsw i64 %15, %17
  %19 = call i32 @test_bswap(i32 noundef 287454020)
  %20 = zext i32 %19 to i64
  %21 = add nsw i64 %18, %20
  %22 = call i32 @test_popcount_logic(i32 noundef -252645136)
  %23 = sext i32 %22 to i64
  %24 = add nsw i64 %21, %23
  %25 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %24)
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
