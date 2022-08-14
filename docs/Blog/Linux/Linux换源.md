# 获取debain版本

[查看 linux 内核版本](获取Linux版本信息.md#查看%20linux%20内核版本)
# Debian

```shell
cat /etc/os-release  
```
- 替换 /etc/apt/sources.list 内容
- 如果无法拉取http源的情况，先使用http源安装
```shell
$ sudo apt install apt-transport-https ca-certificates
```

## 镜像源站:

TUNA清华: https://mirrors.tuna.tsinghua.edu.cn/help/debian/
UTSC中科大: https://mirrors.ustc.edu.cn/help/debian.html

