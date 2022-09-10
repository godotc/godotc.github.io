# SELECT POLL EPOLL

## select
- 每次调用 select， 需要把 `fd_set` that listening 拷贝到 `kernel_status` (内核态)
- 每次 select 返回结果后， 需要遍历文件描述符 判断 读/写
- 内核对监控的文件描述符集合做了限制， 最多为1024 不可改变

## poll
- 改变了 `fd_set` 的记录方式， 通过一个 `pollfd` 数组向内核传递要关注的事件
- 突破了文件描述符的限制

## epoll
- 提供3个 linux API 来实现
- 通过**异步回调**机制来响应就绪的事件
- 内核事件注册表采用红黑树，插入与查询都是 $logN$
- ET 与 LT （边缘与水平触发）
	- LT: `epoll_wait`  每次检测到文件描述符改变，都会向程序发送通知，*可以不用* 立即处理
	- ET:  `epoll_wait` 无论处理不处理 只通知一次
> ET 模式可以减少 `epoll_wait` 的调用

