# SSA
Static Single Assignment

## 概念
每个变量在试用前都必须先定义, 且每个变量只能赋值一次(变量只能被初始化, 不能被赋值)

## SSA 的好处
可以简化编译器的优化过程
```c
d1: y := 1  // 第一次的赋值是无意义的
d2: y := 2 
d3: x := y // 编译器 由 d3 无法知道y是由 d1或是d2 而来
```
但是如果采用SSA:
```c
d1: y1 := 1
d2: y2 := 2
d3: x := y2 // d2 就是 d3 的reaching defintion
```

## 坏处
如果在循环中, 可以对一个值进行多次的赋值, 这样优化会产生多个无意义的值.

在这段代码中发现 %temp 和  %i 进行了多次赋值, 违背了SSA
![](attachments/v2-beebcdc30a8eb251c482f9856fb70de7_r.jpg)
解决方法:
### A: `phi`
在`clang -O1` 下生成的 `.ll` 文件
```c
define dso_local i32 @factorial(i32 noundef %0) local_unnamed_addr #0 {
  %2 = icmp sgt i32 %0, 0
  br i1 %2, label %5, label %3

3:                                                ; preds = %5, %1
  %4 = phi i32 [ 1, %1 ], [ %8, %5 ] ; %4的值 从%1来为1, 从 %5 来 为 %8
  ret i32 %4

5:                                                ; preds = %1, %5
  %6 = phi i32 [ %9, %5 ], [ 0, %1 ]
  %7 = phi i32 [ %8, %5 ], [ 1, %1 ]
  %8 = mul nsw i32 %6, %7
  %9 = add nuw nsw i32 %6, 1
  %10 = icmp eq i32 %9, %0
  br i1 %10, label %3, label %5, !llvm.loop !5
}
```
![](attachments/v2-40c93aafeca39f560d0d555d8a264f54_1440w.jpg)
这样每个变量只被赋值一次, 并且实现了循环递增( IR 内的 `%`局部变量之间循环赋值)

### B:  `alloca, load, store`
使用`clang -emit-llvm -S for.c -o for.ll -O0` 在 O0 下生成IR:
```c
define dso_local i32 @factorial(i32 noundef %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  store i32 1, i32* %3, align 4
  store i32 0, i32* %4, align 4
  br label %5

5:                                                ; preds = %13, %1
  %6 = load i32, i32* %4, align 4
  %7 = load i32, i32* %2, align 4
  %8 = icmp slt i32 %6, %7
  br i1 %8, label %9, label %16

9:                                                ; preds = %5
  %10 = load i32, i32* %4, align 4
  %11 = load i32, i32* %3, align 4
  %12 = mul nsw i32 %11, %10
  store i32 %12, i32* %3, align 4
  br label %13

13:                                               ; preds = %9
  %14 = load i32, i32* %4, align 4
  %15 = add nsw i32 %14, 1
  store i32 %15, i32* %4, align 4
  br label %5, !llvm.loop !6

16:                                               ; preds = %5
  %17 = load i32, i32* %3, align 4
  ret i32 %17
}
```
- 即只要求 IR 的虚拟寄存器是 SSA 的, 而真的内存不需要是SSA的