# 获取Linux版本信息
## 查看 linux 内核版本
```shell
1.
	cat /proc/version
2.
	uname -a
```

## 查看linux 系统版本
```shell
1.
	apt install lsb-release
	lsb_release -a
2.
	cat /etc/redhat-release  // 这种方法适用于Redhat系列 
3.
	cat /etc/issue
4.
	hostnamectl
```

### 查看debian版本
```shell
	cat /etc/debian_version
	
	cat /etc/os-release  
```

## 查看内核操作系统位数
```shell
uname -a
getconfig LONG_BIT
```