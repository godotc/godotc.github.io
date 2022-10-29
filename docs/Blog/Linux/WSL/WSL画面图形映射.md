# WSL画面图像映射

> 参考:https://www.cxyzjd.com/article/qq_41932665/108459723

系统环境:
- wsl2
- archlinux

## 1. 在windows上安装`VcXrsc Serve`

source forge 地址:https://sourceforge.net/projects/vcxsrvo/

>安装参考: https://zhuanlan.zhihu.com/p/150555651

## 2.  在arch上安装xfce4, 和xorg
```bash
pacman -Sy xfce4 xfce4-terminal
pacman -S xorg
```

## 3. 添加 DISPLAY 环境变量

### 查看wsl2的虚拟网卡地址
```shell
$ vim /etc/resolv.conf
去掉下面的generateResolvConf 的注释，禁止地址重新生成改变
# generateResolvConf = false 
nameserver 172.1.2.3（网卡地址)
```
或者在windows上查看后缀为wsl的网卡 ipv4 地址
```cmd
$ ipconfig
```

### 添加到环境变量
```bash
export DISPLAY=172.1.2.3:0 #映射到端口0
```
可添加到 `~/.bashrc` 下

## 4. 添加 DBUS_SESSION_BUS_ADDRES 地址
>bus-daemon是一个后台进程，负责消息的转发。它就像个路由器。最常见的基于dbus的程序也是符合C/S结构的。
原文链接：https://blog.csdn.net/jack0106/article/details/5588057

> 一般是没有这个问题的，但在启动`xfce4` 出现了没有 DBUS address 的问题

创建一个 `debus-daemon`
```bash
$ DBUS_VERBOSE=1 dbus-daemon --session --print-address
unix:abstract=/tmp/dbus-OwZraZmBSp,guid=002b36d66dc7930137742f3a631e27fd
```

将打印出的ip信息映射到环境变量（同上)
```bash
export DBUS_SESSION_BUS_ADDRESS=unix:abstract=/tmp/dbus-OwZraZmBSp,guid=002b36d66dc7930137742f3a631e27fd
```

## 5. 启动

- 在windows上运行`XLaunch` . [1 在windows上安装 VcXrsc Serve](#1%20在windows上安装%20VcXrsc%20Serve)
- 启动xfce4
```bash
$ startxfce4
```
