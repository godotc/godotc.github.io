# gcc 编译器


## 编译选项
|     option      |        second         |    description     |
|:---------------:|:---------------------:|:------------------:|
|       -O        |          0~3          |    三种优化级别    |
|                 |           s           |    最小文件优化    |
|       -f        | no-elide-constructors |   关闭返回值优化   |
|       -I        |                       |   指定头文件目录   |
|       -L        |                       |    指定lib目录     |
|       -l        |                       |     指定lib库      |
|    -nostdlib    |                       | 链接时不要用标准库 |
| -Wl,{arg} |                       | 向链接器传递参数                |


## 编译链接
| option |   second    |     description     |
|:------:|:-----------:|:-------------------:|
|   -E   |   \*.cpp    |    preprocessor     |
|   -S   |   \*.cpp    |   compile to asm    |
|   -c   | \*.cpp \*.o | 生成.o文件,目标文件 |
| -L -o  |   \*.lib    |       连接库        | 

```c
clang *.o
riscv64-linux-gnu-gcc a.c
```

- 头文件如何找到？
```sh
gcc -E a.c --verbose > /dev/null
```
![](attachments/Pasted%20image%2020221025114137.png)

## 优化

![](attachments/Pasted%20image%2020221025120822.png)