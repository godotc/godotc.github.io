# gcc 编译器


## 编译选项
| option |        second         |  description   |
|:------:|:---------------------:|:--------------:|
|   -O   |          0~3          |  三种优化级别  |
|        |           s           |  最小文件优化  |
|   -f   | no-elide-constructors | 关闭返回值优化 |

## 编译链接
| option |   second    |     description     |
|:------:|:-----------:|:-------------------:|
|   -E   |   \*.cpp    |    preprocessor     |
|   -S   |   \*.cpp    |   compile to asm    |
|   -c   | \*.cpp \*.o | 生成.o文件,目标文件 |
| -L -o  |   \*.lib    |       连接库        | 


