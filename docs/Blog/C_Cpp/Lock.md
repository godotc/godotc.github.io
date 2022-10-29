# Lock

## lock_guard 和 unique_lock 的区别
1.  `lock_guard`
- 在**构造**lock_guard对象时 就进行了加锁，直到生命周期结束( return 或出 `{}` )
- 无法手动解锁
```cpp
std::mutex mtx;

void func(int idx){
	std::lock_guard<mutex> lock(mtx);
	cout<< std::this_thread::get_id()<<" "<<idx<<endl;
}
```

2. `unique_lock`
- 可以自己灵活的加锁解锁
- `defer_lock` 为该类的一个参数，用于延迟加锁
 ![](attachments/Pasted%20image%2020221018123516.png)
```cpp
std::mutex mtx;

void func(int idx){
	std::unique_lock lock(mtx, std::defer_lock);

	/*
		先进行一些线程安全的操作
	*/

	lock.lock();
	cout<< std::this_thread::get_id()<<" "<<idx<<endl;
	lock.unlock();

	/*
		再次进行一些线程安全的操作
	*/

	lock.lock(); 
	cout<< std::this_thread::get_id()<<" "<<idx<<endl;
	// 在出定义域后自动释放锁	
}
```
- 一个`unique_lock` 可以和另一个 `swap()`
- 一个`unique_lock` 被`=` 赋值, 右边为另一个u_lock, 源码:
```cpp
void swap(unique_lock& _Other) _NOEXCEPT
{   // swap with _Other
	_STD swap(_Pmtx, _Other._Pmtx);
	_STD swap(_Owns, _Other._Owns);
}
unique_lock& operator=(unique_lock&& _Other) _NOEXCEPT
{   
	// destructive copy
	if (this != &_Other)
	{   
		// different, move contents
		if (_Owns)
			_Pmtx->unlock();
		_Pmtx = _Other._Pmtx;
		_Owns = _Other._Owns;
		_Other._Pmtx = 0;
		_Other._Owns = false;
	}
	return (*this);
}
```