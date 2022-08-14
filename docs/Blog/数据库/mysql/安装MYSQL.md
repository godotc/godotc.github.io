# 从bundle安装
## Debian
>系统信息:
PRETTY_NAME="Debian GNU/Linux 11 (bullseye)"
NAME="Debian GNU/Linux"
VERSION_ID="11"
VERSION="11 (bullseye)"
VERSION_CODENAME=bullseye
ID=debian
HOME_URL="https://www.debian.org/"
SUPPORT_URL="https://www.debian.org/support"
BUG_REPORT_URL="https://bugs.debian.org/"

> mysql版本:
mysql-server_8.0.30-1debian11_amd64.deb-bundle

1. 于debian系列系统下，从官网下载deb bundle包后
2. 使用 tar -xfv 解压 tar 包，然后 根据依赖使用 dpkg -i 依次安装
	- [ERROR] no usable dialog-like program is installed
		- apt install Dialog

3. mysqld --user=root, 启动成功
4. run mysql_security_installation 进行安全管理