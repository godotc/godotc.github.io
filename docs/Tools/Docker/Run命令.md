# Run 命令及参数的使用

> docker run: 使用一个镜像来创建一个新容器附加相应的参数

## 普通的运行
```shell
$ docker run -it -p 80:80 /bin/bash  -v  `pwd`:`pwd` debian:latest
$ docker run -d -P ubuntu
```


## 选择镜像和容器名字(--name)
```sh
--name [容器名字]
```
---

## 网络配置

### --net
1. --net=bridge 这个是默认值，连接到默认的网桥。(分配172.**地址)
2. –net=host 共享主机网络空间，可以像普通进程一样进行通信(不分配独立地址)
3. -–net=container:NAME_or_ID 让 Docker 和已存在的容器共享 IP 地址和端口等网络资源，两者进程可以直接通过 lo 环回接口通信。
4. -–net=none 让 Docker 将新容器放到隔离的网络栈中，但是不进行网络配置。之后，用户可以自己进行配置。

> 使用 --net=container:NAME_or_ID 运行一组docker cluster 进行集成环境测试

### 自定义网络

在[ 自定义网络](docker网络管理.md#2%20自定义网络)后:
```shell
$ docker run --net={custom_net} ...
```


## 端口映射(-p/P)

    -p [本机端口]:[容器端口]  (可多次使用-p 映射多个端口)

    -P 随机映射一个本机端口到容器的80端口

## 启动模式
    -d --detach 指定后台运行

    -i 以交互模式启动，通常与-t联用

    -t 选择一个shell程序使用 如: -it /bin/bash

## 连接到标准输出(-a)

-a 标志告诉 docker run 绑定到容器的STDIN，STDOUT或STDERR。 这使得可以根据需要操纵输出和输入。

```shell
$ docker run -a stdout ubuntu echo test
test
```

## 完整容器能力 (–privileged)

特权容器？

默认情况下，大多数潜在危险的内核功能都会被删除; 包括 cap_sys_admin（挂载文件系统所需）。 但是，–privileged标志将允许它运行。

```shell
$ docker run -t -i --privileged ubuntu bash
```

--privileged 标志为容器提供了所有功能，它还解除了设备cgroup控制器强制执行的所有限制。 换句话说，容器几乎可以完成主机可以执行的所有操作。 此标志存在以允许特殊用例，例如在Docker中运行Docker。

## 设置工作目录 (-w)

```shell
$ docker  run -w /path/to/dir/ -i -t  ubuntu pwd
/path/to/dir
```

-w 允许命令在给定的目录中执行，这里是 /path/to/dir/。 如果路径不存在，则在容器内创建。

## 挂载卷 (-v, –read-only)

```shell
docker  run  -v `pwd`:`pwd` -w `pwd` -i -t  ubuntu pwd
```

-v 标志将当前工作目录挂载到容器中。 -w 让命令在当前工作目录中执行，方法是将工作目录更改为pwd返回的值。所以这个组合使用容器执行命令，但在当前工作目录中。

## 设置环境变量(-e , -env, -env-file)
可以通过 -e , -env, -env-file 设置容器的环境变量

```shell
$ docker run -e ENV_VAR --env ENV_VAR2=xxx --env-file ./env.list debain bash
```

本地已经 export 的环境变量，可以不用赋值
```bash
export VAR1=value1
export VAR2=value2

$ docker run --env VAR1 --env VAR2 ubuntu env | grep VAR
VAR1=value1
VAR2=value2
```

## 从容器挂载卷(–volumes-from)

```bash
docker run --volumes-from 777f7dc92da7 --volumes-from ba8c0c54f0f2:ro -i -t ubuntu pwd
```

## 资源分配
```shell
--cpu-period=[number]
--cput-quota=[number] # 只能使用 number/1000 ms 的cpu
```

## 命令详解
Usage: docker run [OPTIONS] IMAGE [COMMAND] [ARG...]  

```shell

  -d, --detach=false         指定容器运行于前台还是后台，默认为false   
  -i, --interactive=false    打开STDIN，用于控制台交互  
  -t, --tty=false            分配tty设备，该可以支持终端登录，默认为false  
  -u, --user=""              指定容器的用户  
  -a, --attach=[]            登录容器（必须是以docker run -d启动的容器）  
  -w, --workdir=""           指定容器的工作目录   
  -c, --cpu-shares=0        设置容器CPU权重，在CPU共享场景使用  
  -e, --env=[]               指定环境变量，容器中可以使用该环境变量  
  -m, --memory=""            指定容器的内存上限  
  -P, --publish-all=false    指定容器暴露的端口  
  -p, --publish=[]           指定容器暴露的端口   
  -h, --hostname=""          指定容器的主机名  
  -v, --volume=[]            给容器挂载存储卷，挂载到容器的某个目录  
  --volumes-from=[]          给容器挂载其他容器上的卷，挂载到容器的某个目录  
  --cap-add=[]               添加权限，权限清单详见：http://linux.die.net/man/7/capabilities  
  --cap-drop=[]              删除权限，权限清单详见：http://linux.die.net/man/7/capabilities  
  --cidfile=""               运行容器后，在指定文件中写入容器PID值，一种典型的监控系统用法  
  --cpuset=""                设置容器可以使用哪些CPU，此参数可以用来容器独占CPU  
  --device=[]                添加主机设备给容器，相当于设备直通  
  --dns=[]                   指定容器的dns服务器  
  --dns-search=[]            指定容器的dns搜索域名，写入到容器的/etc/resolv.conf文件  
  --entrypoint=""            覆盖image的入口点  
  --env-file=[]              指定环境变量文件，文件格式为每行一个环境变量  
  --expose=[]                指定容器暴露的端口，即修改镜像的暴露端口  
  --link=[]                  指定容器间的关联，使用其他容器的IP、env等信息  
  --lxc-conf=[]              指定容器的配置文件，只有在指定--exec-driver=lxc时使用  
  --name=""                  指定容器名字，后续可以通过名字进行容器管理，
							  links特性需要使用名字  
							  
  --net="bridge"             容器网络设置:  
								bridge 使用docker daemon指定的网桥   
								host    //容器使用主机的网络  
								container:NAME_or_ID  >//使用其他容器的网路，共享IP和PORT等网络资源  none 容器使用自己的网络（类似--net=bridge），但是不进行配置   
							
  --privileged=false         指定容器是否为特权容器，特权容器拥有所有的capabilities  
  --restart="no"             指定容器停止后的重启策略:  
                                no：容器退出时不重启  
                                on-failure：容器故障退出（返回值非零）时重启   
                                always：容器退出时总是重启 
                                 
  --rm=false                 指定容器停止后自动删除容器
							  (不支持以docker run -d启动的容器)  
							  
  --sig-proxy=true           设置由代理接受并处理信号，但是SIGCHLD、SIGSTOP和
							  SIGKILL不能被代理  

```
