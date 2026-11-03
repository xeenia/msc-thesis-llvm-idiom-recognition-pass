; ModuleID = '/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../src/positive_tests.c'
source_filename = "/home/xenia/Projects/msc-thesis-llvm-idiom-recognition-pass/llvm-pattern-select-main/tests/scripts/../src/positive_tests.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @times8(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = mul nsw i32 %3, 8
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @mod32(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, ptr %2, align 4
  %3 = load i32, ptr %2, align 4
  %4 = urem i32 %3, 32
  ret i32 %4
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_rotate(i32 noundef %0) #0 {
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
define dso_local i32 @test_abs(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  %4 = load i32, ptr %3, align 4
  %5 = icmp slt i32 %4, 0
  br i1 %5, label %6, label %9

6:                                                ; preds = %1
  %7 = load i32, ptr %3, align 4
  %8 = sub nsw i32 0, %7
  store i32 %8, ptr %2, align 4
  br label %11

9:                                                ; preds = %1
  %10 = load i32, ptr %3, align 4
  store i32 %10, ptr %2, align 4
  br label %11

11:                                               ; preds = %9, %6
  %12 = load i32, ptr %2, align 4
  ret i32 %12
}

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @test_max(i32 noundef %0, i32 noundef %1) #0 {
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
define dso_local i32 @test_min(i32 noundef %0, i32 noundef %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, ptr %3, align 4
  store i32 %1, ptr %4, align 4
  %5 = load i32, ptr %3, align 4
  %6 = load i32, ptr %4, align 4
  %7 = icmp slt i32 %5, %6
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
define dso_local i32 @test_bswap(i32 noundef %0) #0 {
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
define dso_local i32 @test_popcount_logic(i32 noundef %0) #0 {
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
define dso_local i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i64, align 8
  store i32 0, ptr %1, align 4
  store i64 0, ptr %2, align 8
  %3 = call i32 @times8(i32 noundef 5)
  %4 = sext i32 %3 to i64
  %5 = load i64, ptr %2, align 8
  %6 = add nsw i64 %5, %4
  store i64 %6, ptr %2, align 8
  %7 = call i32 @mod32(i32 noundef 45)
  %8 = zext i32 %7 to i64
  %9 = load i64, ptr %2, align 8
  %10 = add nsw i64 %9, %8
  store i64 %10, ptr %2, align 8
  %11 = call i32 @test_rotate(i32 noundef 305419896)
  %12 = zext i32 %11 to i64
  %13 = load i64, ptr %2, align 8
  %14 = add nsw i64 %13, %12
  store i64 %14, ptr %2, align 8
  %15 = call i32 @test_abs(i32 noundef -15)
  %16 = sext i32 %15 to i64
  %17 = load i64, ptr %2, align 8
  %18 = add nsw i64 %17, %16
  store i64 %18, ptr %2, align 8
  %19 = call i32 @test_max(i32 noundef 10, i32 noundef 25)
  %20 = sext i32 %19 to i64
  %21 = load i64, ptr %2, align 8
  %22 = add nsw i64 %21, %20
  store i64 %22, ptr %2, align 8
  %23 = call i32 @test_min(i32 noundef 10, i32 noundef 25)
  %24 = sext i32 %23 to i64
  %25 = load i64, ptr %2, align 8
  %26 = add nsw i64 %25, %24
  store i64 %26, ptr %2, align 8
  %27 = call i32 @test_bswap(i32 noundef 287454020)
  %28 = zext i32 %27 to i64
  %29 = load i64, ptr %2, align 8
  %30 = add nsw i64 %29, %28
  store i64 %30, ptr %2, align 8
  %31 = call i32 @test_popcount_logic(i32 noundef -252645136)
  %32 = sext i32 %31 to i64
  %33 = load i64, ptr %2, align 8
  %34 = add nsw i64 %33, %32
  store i64 %34, ptr %2, align 8
  %35 = load i64, ptr %2, align 8
  %36 = call i32 (ptr, ...) @printf(ptr noundef @.str, i64 noundef %35)
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
