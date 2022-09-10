# 多进程与多线程

## 多进程
### 1. Context 上下文 切换开销
- 页表目录项更新
- 寄存器中的数据
- 切换 kernel status stack （内核态栈）
- Flush TLB
- L1 ~ L3 的 cache indirectly expired (disabled). Directly access memory.
	
### 2. 进程的共享空间
- 进程不共享栈空间， 每个 Process 都有 independent virtual address space (独立的虚拟地址空间)
- 共享内存

### 3. 进程的三种状态:
- 就绪 Ready
- 运行 Running
- 阻塞 Blocking

### 4. IPC (Internal Process Contact) 进程间通信
1. `pipe` , `fifo` 管道
2. Memory Share
3. Message Queue
4. Signal (开销小，但传递的信息简单)
5. Semaphore （信号量）
6. **Socket** （常用）
	
### 5.  僵尸进程
 - 子进程先结束，父进程没有回收掉子进程的资源，显示为 `zoobie` Process

### 6. 孤儿进程
- 父进程先结束，子进程仍然存活， 将由系统的 init 进程负责回收相关资源

## 多线程
### 1. 线程间同步
1. 互斥锁
2. 读写锁
3. 条件变量 `condition_variable`
4. 信号量
5. 自旋锁（avoid 进程或线程的 context 切换开销)

### 2. 线程共享的资源
1. 文件描述符 (`fd` 内核管理)
2. `PID` 和 `PGID`
3. 同进程的内存地址空间：
	1. `.text`  代码段
	2. `.data` 数据段
	3. `.bss`  未初始化数据段
	4.  堆区
	5. 全局变量
	6. 静态变量
4. 每种信号的 handler (处理方式)
5. 进程的当前目录 `cwd`

### 3. 线程独享的资源
1. 线程的 stack 
2. 寄存器的值
3. 线程ID `TID`
4. 错误返回的 `errno` 变量
5. 线程信号屏蔽字
6. 线程优先级


