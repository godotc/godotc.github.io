# 1. 获取 container 的内网IP地址

1. 进入容器内部后

```shell
cat /etc/hosts  #会显示自己以及(– link)软连接的容器IP
```

2.使用命令
``` shell
docker inspect <container id>

或 docker inspect --format '{{ .NetworkSettings.IPAddress }}' <container-ID>


或   docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container_name_or_id
```

3.可以考虑在 ~/.bashrc 中写一个 bash 函数：

```shell
function docker_ip() {
    sudo docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1
}
source ~/.bashrc 然后：

$ docker_ip <container-ID>

172.17.0.6
```
4.要获取所有容器名称及其IP地址只需一个命令。

```
docker inspect -f '{{.Name}} - {{.NetworkSettings.IPAddress }}' $(docker ps -aq)
```

- 如果使用docker-compose命令将是：

```shell
docker inspect -f '{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)
```

5.显示所有容器IP地址：
```shell
docker inspect --format='{{.Name}} - {{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker ps -aq)

```

>版权声明：本文为CSDN博主「sannerlittle」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
  原文链接：https://blog.csdn.net/sannerlittle/article/details/77063800
  
---


# 2. 自定义网络

- container的默认ip为172.\*\*，网关也同样为172.\*\*
- 这样导致容器在不同的网关下不能ping通
---
### 创建自定义网络

1. 于是我们可以使用 `docker network create` 创建一个于本地下的网络

```shell
$ docker network create --driver bridge --subnet 192.168.0.0/16 --gateway 192.168.0.1 custom-net

$ docker inspect custom-net
```
2. 于是在[自定义网络](Run命令#网络配置#自定义网络) 中加入:
	- --net=custom-net
3. 网络连通
---
### 自定义网络的优点

1. 部署集群时，如mysql集群使用同一个网桥，使其能够相互访问；
2. 不同集群、应用使用不同的网桥，做网络隔离；
3. 有利于集群的健康安全，方便网络管理。