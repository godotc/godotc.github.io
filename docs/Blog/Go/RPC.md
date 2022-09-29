# RPC
![](attachments/Pasted%20image%2020220926120610.png)

- 3 个实例来进行远程调用
- Consumer getProxy(interfacename), 获得一个handler(函数指针或者proxyInstace), 来调用远端的方法
- Consumer 在获取到远端主机后本地采用url缓存加速进程
- 注册中心使用 zookeeper，redis 来实行集群管理（provider挂掉等等）
- Provider 在本地注册可以 remote call 的方法
- 在公共位置保存interface

## 如何实现注册中心
- 共享一些数据（注册的主机地址等等）
- 心跳检测 （集群管理, 检测Provider是否在线）
- 监听机制（consumer 如何得知 远端的数据变化）


## 非阻塞
- C++  同步阻塞地调用 异步非阻塞地调用 (以callback形式)
- go 同步非阻塞 (协程)

## 实现方式
- 一开始采用json但是效率太低，心啊在一般都是protobuf
- protobuf 采用接口描述语言 IDL(interface descripted language)来编写

## GRPC 4种模式
grpc 自带的四种范例
1. 一元rpc  
	- 一个请求一个回应
	- 返回的是response结构体
	
 ![](attachments/Pasted%20image%2020220929104232.png)
 
 2. 服务器端流
	 - 一个请求多个回应
	 - 返回的是 stream 流(音视频回应)
	 
![](attachments/Pasted%20image%2020220929104254.png)

3. 客户端流
	- 多个请求一个回应
	- 发送的是stream，传送连续的信息
	- 返回一个 summary 对流的总回应（如传文件，文字流）
	
![](attachments/Pasted%20image%2020220929104345.png)

4. 双向流
	- 双方都是 stream 来交流与回应
	- 以 EOF 认定为结束
	
![](attachments/Pasted%20image%2020220929104356.png)