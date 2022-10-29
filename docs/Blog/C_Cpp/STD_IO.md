## STD_IO 相关

## 1. `cout` 固定小数位数
```cpp
	#include<iostream>
	#include<iomanip>
	std::cout<<std::fixed<<std::setprecision(5)<< number<<std::endl;

	- if no std::fixed
	- output will be scientific notation format.
```
```c
	#include<stdio.h>
	printf("%.5lf",number);
```

---
## 2. 重载操作符 `<<`

 Overload `<<` can't be a member function,  Because  It's a Linked-Like coding (链式编程). It will always return `std::ostream&`
 
1. Use friend function define in class. Also can declare it outside as global function,
2. Use class's print function to access private members.
3. Use transition-timing-function (过渡函数):
```cpp
 class Test{
	std::ostream& Output(std::ostream& out){
		return out<<"data: "<< data;
	}

	Test data;
}

std::ostream& operator<< (std::ostream& out, Test& test){
	return test.Output(out);
}

```

## 3. 格式化字符串
- 当传入的是一个 `format,....` 可变参时，需要用 `va_list` 来接住参数
```cpp
va_list arg_ptr;
va_start(arg_ptr, format);
int size = vsnprintf(NULL,0,format,arg_ptr);
va_end(arg_ptr);
```
**注意**： 在用`vsnprintf` 获取长度后，先`va_end(arg_ptr)`, 然后需要再次使用一轮`va_...`函数来获取可变参数
否则会产生乱码

- 在输出到某个缓冲区中需要使用`vnsprintf` 函数，否则打印出不参数
```cpp
vsprintf(buf, size+1, format, arg_ptr ); // 错误，无法显示参数

va_list arg_ptr;
va_start(arg_ptr, format);
vnsprintf(buf, size+1, format, arg_ptr ); 
va_end(arg_ptr);
```

