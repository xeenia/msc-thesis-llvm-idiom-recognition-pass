; ModuleID = '/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../ir/positive_tests_before.ll'
source_filename = "/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../src/positive_tests.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @times8(i32 noundef %0) #0 {
  %2 = shl nsw i32 %0, 3
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @mod32(i32 noundef %0) #0 {
  %2 = and i32 %0, 31
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_rotate(i32 noundef %0) #0 {
  %2 = call i32 @llvm.fshl.i32(i32 %0, i32 %0, i32 8)
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_abs(i32 noundef %0) #0 {
  %2 = call i32 @llvm.abs.i32(i32 %0, i1 true)
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_max(i32 noundef %0, i32 noundef %1) #0 {
  %3 = call i32 @llvm.smax.i32(i32 %0, i32 %1)
  ret i32 %3
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_min(i32 noundef %0, i32 noundef %1) #0 {
  %3 = call i32 @llvm.smin.i32(i32 %0, i32 %1)
  ret i32 %3
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_bswap(i32 noundef %0) #0 {
  %2 = call i32 @llvm.bswap.i32(i32 %0)
  ret i32 %2
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_popcount_logic(i32 noundef %0) #0 {
  %2 = call i32 @llvm.ctpop.i32(i32 %0)
  ret i32 %2
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

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.fshl.i32(i32, i32, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.abs.i32(i32, i1 immarg) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.bswap.i32(i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.ctpop.i32(i32) #2

attributes #0 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }

!llvm.module.flags = !{!0, !1, !2, !3, !4}
!llvm.ident = !{!5}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 8, !"PIC Level", i32 2}
!2 = !{i32 7, !"PIE Level", i32 2}
!3 = !{i32 7, !"uwtable", i32 2}
!4 = !{i32 7, !"frame-pointer", i32 2}
!5 = !{!"clang version 17.0.1 (https://github.com/llvm/llvm-project.git e19b7dc36bc047b9eb72078d034596be766da350)"}
