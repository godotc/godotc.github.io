# RISC-V

![](attachments/Pasted%20image%2020221025094807.png)
![](attachments/Pasted%20image%2020221025095238.png)

## 状态机
![](attachments/Pasted%20image%2020221025104807.png)
- fcompile 从 语言(C)状态机 映射到 IS(指令集)的状态机
- 再把指令集状态机 映射到 逻辑电路的状态机上
fstat:  {R, M} -> {时序逻辑电路}
fuarch: {command} -> {组合逻辑电路}
![](attachments/Pasted%20image%2020221025105542.png)

- 三个状态机的联系:
S_c ~ S_isa ~ S_cpu

![](attachments/Pasted%20image%2020221025105919.png)
![](attachments/Pasted%20image%2020221025113320.png)

## freestanding
[编译选项](../../Library/GNU/gcc编译器.md#编译选项)
![](attachments/Pasted%20image%2020221029000118.png)

## 自制一个 freestanding runtime 环境
![](attachments/Pasted%20image%2020221029151808.png)
### 如何制造 runtime ?
![](attachments/Pasted%20image%2020221029153628.png)

- 用变量实现寄存器和内存模型
```c
uint64_t R[32],pc; // accroding to RISC-V manual
uint8_t M[64];  // 64-Byte memory
```
> 使用 int 溢出是 undefine behavior, 但uint 不会

![](attachments/Pasted%20image%2020221029154025.png)

![](attachments/Pasted%20image%2020221029174656.png)

![](attachments/Pasted%20image%2020221029184715.png)