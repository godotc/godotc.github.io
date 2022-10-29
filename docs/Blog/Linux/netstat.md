# netstat 命令

## 查看端口占用情况
```sh
netstat -tunlp | grep port
 -t (tcp) 仅显示tcp相关选项
 -u (udp)仅显示udp相关选项
 -n 拒绝显示别名，能显示数字的全部转化为数字
 -l 仅列出在Listen(监听)的服务状态
 -p 显示建立相关链接的程序名
```
or
```sh
lsof -i:port
```

>btw: On `windows`
```cmd
netstat -ano | findstr "port"
taskkill /f /t / /im task.exe
```

