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
