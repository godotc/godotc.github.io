# 如何实现隔离
> see as https://blog.51cto.com/u_11440114/3001912

## Linux Namespace
![](attachments/Pasted%20image%2020221002203038.png)

## 挂载 /proc

`/proc` 文件夹 是一个伪文件系统，他只存在于当前内存中
- `mount -h` 
![](attachments/Pasted%20image%2020221002165317.png)
![](attachments/Pasted%20image%2020221002165337.png)

### mount 命令格式
```shell
mount -t type device dir
```

- 在 `initrd` 中的写法
``` shell
$ mount -t proc proc /proc # 在initrd中的写法
```
> 即 `proc` 其实是一种文件系统
 命令把`proc`这个个虚拟文件系统挂载到 `/proc` 目k录
 第二个proc被显示在mount的输出中
```shell
'proc on /proc type proc (rw,noexec,nosuid,nodev)'
```

- 若写成
```shell
$ mount -t proc /proc /proc
'/proc on /proc type proc(...)'
```
即 显示的第一个标志 改变

- 也可以这样写：
```shell
$ mount -t proc none /proc
```
- 甚至可以把none换成任意字母的组合，如：
```shell
$ mount -t proc lkdsfadflkjlkj /proc
```
但显然没有人会这么做。因为谁都不希望在运行mount命令时看到令人不解的输出，所以说还是none最合适

