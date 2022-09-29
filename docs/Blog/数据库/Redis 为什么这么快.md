# Why Redis so fast?
## 1. Is redis is single thread?
- No, Redis is not single thread. It have multiply thread into its process
- But, All commands and service only received and handled by the Main Thread（ Redis Server )

## 2. Why handle operator with single-thread?
1. 通常进程内部有以下几个线程:
	- redis-server
	- bio_close_file (close big file)
	- bio_aof_fsync (持久化刷盘)
	- bio_lazy_free (free big memory)
	- io_thd_1/2/3 (网络IO)
	- jemalloc_bg_thread (分配内存)

 2. Long-Running (耗时) Operator 有:
	- IO 密集
	- CPU 密集
disk IO、持久化 (data persistence: rdb, aof, aof复写,rdb-aof 混用) 、
Close大文件、 异步持久化文件，产生 IO intensive（密集）操作。
于是在别的线程中进行这些操作

3. 如果采用多主线程有什么问题？
	- 在不同的线程间加锁影响性能，锁复杂，粒度不好控制
	- 线程切换不涉及虚拟地址空间，但是频繁上下文切换会导致缓存失效，或雪崩
4. 为何这么快？
	1. 采用了内存结构体来存储
	2. reactor 模型的主线程服务，一个请求一个回应，以事件回调来异步处理指令，不用生成多条线程来服务链接，在io循环中由创建好的工作线程来处理
	3. 将 阻塞的 耗时操作由工作线程异步处理
	4. 将复杂的IO密集，cpu密集工作分治为小工作，如将rehash分摊在每个操作中
	5. 高效的数据组织结构方式--hashtable：O(1），两个 hashtable 来应对扩容
	6. 高效的数据结构: string: int-raw-embstr, hash: ziplist-dict, list: quicklist(每一个节点为ziplist), set: intset-skiplist+dict, 并且内置 stream 消息队列。 在执行效率和空间占用保持均衡
	

## 3. 源码结构
- redisDb 结构体（16个之一）储存了这个db的所有数据
