# GDB
---
see more TUI commands in: https://ftp.gnu.org/old-gnu/Manuals/gdb/html_chapter/gdb_19.html

`gdb file -ex "b main"` 添加断点于main
- 多行命令指定多个 `-ex`

## 开启TUI

### 1.  开启TUI hotkey
- `ctrl+x a`    启动TUI
- `ctrl+x A` 退出TUI
- `ctrl+x 2` 切换布局

### 2.  Command Line for Layout
- `layout next`
 Display the next layout.
- `layout prev`
Display the previous layout.
- `layout src`
Display the source window only.
- `layout asm`
Display the assembly window only.
- `layout split`
Display the source and assembly window.
- `layout regs`
Display the register window together with the source or assembly window.
- `focus next | prev | src | asm | regs | split`
Set the focus to the named window. This command allows to change the active window so that scrolling keys can be affected to another window.
- `refresh`
Refresh the screen. This is similar to using C-L key.
- `update`
Update the source window and the current execution point.
- `winheight name +count/-count`
Change the height of the window name by count lines. Positive counts increase the height, while negative counts decrease it.

---
## GDB 调试指令
### 1. HOT KEY
- `C+p` 上一条指令

### 2. COMMAND
- `python ...` run python script
- `python` write a python script
---

#### 运行
- `r` run 运行
	 - `r -l -a a.txt` 执行 `argc` 与 `argv`
- `s` step 向后一部
- `n` next 向后一行
- `c` continue 向后执行到断点或结束
- `k` kill 杀死当前线程
- `finish` 执行到当前函数返回
- `x` 扫描内存


- `starti` 从程序的第一条指令开始(不是main)

####  断点

- `b/break n`  在n行打断电
- `tb`  临时断点 只触发一次
- `pyhton gdb.Breakpoint('n')`
- `b namespace::function(para)` 在特定函数下断点，不加para在所有重载打断点

- `python print(gdb.breakpoints())` 查看断点
- `d n`  删除n号断点

##### 条件断点

`b [func or line]  if [conditon]` :
```shell
b func if ptr == nullptr
```

##### 监视变量
`watch valriable` 如果变量被修改，程序会暂停
`awatch ..` 读写都会打断点

##### 保存断点
使用 `save breakpoints file.gdb` 来保存打下的断点到`.gdb`中
下次运行时使用`source file.gdb` 来读取

`file.gdb` like:
```shell
file a.out
b main
run val1 val2
```

#### 观察
1. `p/print target` 打印:
	- `p 变量` 打印变量信息
	- `p val=..` 运行时改变变量
2. `bt`  栈回溯 (从哪里进入的函数，call stack of before)
3. `l [file/func]:n`  查看 某文件或函数(可选) 的第几行

4. `backward-cpp` 项目 on github, 更详细的错误stack trace

## 进入 系统进程/线程
```shell
ls -lth core*
gdb -c core.[TID]

```

`attach TID`  来附加到以运行的线程上
