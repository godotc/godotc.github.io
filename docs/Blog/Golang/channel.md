# Channel

- 类似于管道，进行发送和接收数据， 操作符是 `<-` （数据流向）
```go
ch <- V // 发送 v 到 chan ch 中
V := <-ch  // V 的值为 从管道中 接收数j据
```

- 通过 `<-` 指定数据方向，如果没有指定则是双向的，既可以接收也可以发送数据
```go
chan T // 可以接收与发送 T 类型 data
chan<- float64 // only 发送 f64 只写
<-chan int // only 接收 int  只读

```

```go
ch := make(chan int, bufsize) // ch 为 可以send/receive int, bufzie 参数决定管道是否有缓冲（异步）
```