# clang

生成目标框架代码
```c
clang -S a.c --target=riscv64 -march=rv64g
```

查看clang进行了哪些优化
```c
clang -S a.c -ftime-report
```
