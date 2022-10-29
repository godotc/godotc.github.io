# args

- -n 只打印命令但不执行
- -- trace 输入目标被构建的原因和命令
- -d 查看调试日志，make 如何抉择
- -nB 强制构建所有目标
```sh
make -nB | vim -
只保留 gcc 或 g++ 开头的行
:%!grep "^\(gcc\|g++\)" 

将环境b变量进行替换
:%!sed -e "s+NEMU_HOME+\$NEMU_HOME+g"

将 -c 之间的内容 替换为 $CFLAGS
:%s/-O2.*=riscv64/$CFLAGS/g

将最后一行的空格替换成换行并缩进两格
:$s/ */\r /g

```