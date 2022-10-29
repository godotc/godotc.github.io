# LLVM IR 快速上手
> see as: https://buaa-se-compiling.github.io/miniSysY-tutorial/pre/llvm_ir_ssa.html

- IR 的好处
>  首先，有一些优化技术是目标平台无关的（例如作为我们实验挑战任务的死代码删除和常量折叠），我们只需要在 IR 上做这些优化，再翻译到不同的汇编，这样就能够在所有支持的体系结构上实现这种优化，这大大的减少了开发的工作量。
    
> 其次，假设我们有 `m` 种源语言和 `n` 种目标平台，如果我们直接将源代码翻译为目标平台的代码，那么我们就需要编写 `m * n` 个不同的编译器。然而，如果我们采用一种 IR 作为中转，先将源语言编译到这种 IR ，再将这种 IR 翻译到不同的目标平台上，那么我们就只需要实现 `m + n` 个编译器。

- 架构:
	- front-end: 将 source 编译到 IR
	- intermediate-end: 对 IR 进行优化
	- back-end: 将IR翻译为目标机器语言
![](attachments/llvm_compiler_pipeline.png)
- IR 的三种表现形式(格式):
	1. 在内存中的编译中间语言(无法通过文件的形式得到)
	2. 硬盘中的 binary 中间语言 (`.bc`)
	3. 人类可读IR (`.ll`)

## 类型系统
1. void
2. integer
`i1`, `i32`, `i64`, 
3. label
标签类型, 用作代码标签
```c
br i1 %9, label %10, label %11
br label %12
```