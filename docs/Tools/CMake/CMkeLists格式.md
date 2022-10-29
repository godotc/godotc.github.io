# CAMKELISTS.TXT

## 样式
---
1. 顶层
```cmake
CMAKE_MINIMUM_REQUIRED(VERSION 2.8) # CMake 最低版本要求，低于2.6 构建过程会被终止。 
 
PROJECT(server_project)                  #定义工程名称
 
MESSAGE(STATUS "Project: SERVER")               # 打印相关消息消息 
MESSAGE(STATUS "Project Directory: ${PROJECT_SOURCE_DIR}")
 
SET(CMAKE_BUILE_TYPE DEBUG)       # 指定编译类型，debug 或release
```
>debug 版会生成相关调试信息，可以使用  [gdb](../../Library/GNU/GDB.md) 进行 
 release不会生成调试信息。当无法进行调试时查看此处是否设置为 debug.
 
    ```cmake
    SET(CMAKE_C_FLAGS_DEBUG "-g -Wall")          # 指定编译器 
                # CMAKE_C_FLAGS_DEBUG            ----  C 编译器
                                                # CMAKE_CXX_FLAGS_DEBUG        ----  C++ 编译器
                                                # -g：只是编译器，在编译的时候，产生调试信息。
                                                # -Wall：生成所有警告信息。一下是具体的选项，可以单独使用
    
    ADD_SUBDIRECTORY(utility)                    # 添加子目录 
    ADD_SUBDIRECTORY(server)
    ```

2. 单个工程 
```cmake
SET(SOURCE_FILES ConfigParser.cpp StrUtility.cpp) # 设置变量，表示所有的源文件
 
INCLUDE_DIRECTORIES(/usr/local/include ${PROJET_SOURCE_DIR}/utility)
                                                   # 相关头文件的目录
 
LINK_DIRECTORIES(/usr/local/lib)      # 相关库文件的目录
 
ADD_LIBRARY(association ${SOURCE_FILES})         # 生成静态链接库libassociation.a
TARGET_LINK_LIBRARY(association core）            # 依赖的库文件

SET_TARGET_PROPERTIES(utility  PROPERTIES # 表示生成的执行文件所在路径
RUNTIME_OUTPUT_DIRECTORY> "${PROJECT_SOURCE_DIR}/lib")
```

## 输出路径设置
---
1. 设置可执行文件的输出路径：

SET(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/../bin)

2. 静态库 lib 输出路径：

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/../bin)

3. 动态库输出路径（注意这个放在最后）：
```cmake
SET_TARGET_PROPERTIES(dllname PROPERTIES RUNTIME_OUTPUT_DIRECTORY ../bin)
```


## 属性设置
---

1. 设置Debug版本和Release版本下库文件的后缀名
```cmake
set(CMAKE_DEBUG_POSTFIX "_d")    set(CMAKE_RELEASE_POSTFIX "_r") 
```

2. 设置Debug版本和Release版本下可执行文件的后缀名
```cmake
set_target_properties(${TARGET_NAME} PROPERTIES DEBUG_POSTFIX "_d")     
set_target_properties(${TARGET_NAME} PROPERTIES RELEASE_POSTFIX "_r")
```

3.设置链接库名称：
```cmake
target_link_libraries()

target_link_libraries(
	        DealWithMould
             ${VTK_LIBRARIES}
             )

target_link_libraries(myProject hello) 
```

>————————————————
版权声明：本文为CSDN博主「恋恋西风」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/q610098308/article/details/121157418


