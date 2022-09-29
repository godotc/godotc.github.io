# Modern CMAKE

- `-B`  指定 build 目录
- `--build` 进行构建 （进入 build 目录下）
```cmake
cmake -B build
cmake --build ./build
```

## 1. 添加 source
```cmake
 add_executable(main) (之前)
 target_sources(main PUBLIC main.cpp) (之后)
```

### 批量添加 sources

#### 1.  使用file()函数 和 GLOB参数
```cmake
add_executale(main)
file(GLOB sources   CONFIGURE_DEPENDS ./src/*.cpp ./include/*.h) 
target_sources(main PUBLIC ${sources})
```

#### 2.  GLOB_RECURSE： 
 - 递归地查找子目录
 - 但是会把build目录下的临时`.cpp`文件也加进来,  解决方法: **不要**把源码放在与**build 目录同级**下
 
#### 3. CONFIGURE_DEPENDS 参数:
每次build 更新源文件( configure 一遍) (否则可能已添加或删除的源文件未检测到)

#### 4. aux_source_directory() 函数
```cmake
add_executable(main)
aux_source_directory(. sources)
aux_source_directory(lib sources)
aux_source_directory(src sources)
target_sources(main PUBLIC ${sources})
```

## 2. 添加库
### 静态库
```cmake
add_library(mylib STATIC mylib.cpp)
file(GLOB blib_src blib/*.cpp)
add_library(blib STATIC ${blib_src})

target_link_libraries(main PUBLIC mylib)
```

### 动态库
- 根据 `BUILD_SHARED_LIB` 这个变量的值决定为动态还是静态
- ON 相当于 SHARED, OFF 相当于 STATIC
- 如果未指定，则默认为 STATIC
> 如果一个项目里的 `add_Llibrary()` 里是无参数的，则可以使用 `cmake -B build -D BUILD_SHARED_LIBS:BOOL=ON`, 来使他全部生成静态库

```cmkae
set(BUILD_SHARED_LIBS ON)
```

#### 坑点：动态库无法链接静态库
```cmake
add_library(otherlib STATIC otherlib.cpp)

add_library(mylib SHARED mylib.cp)
target_link_libraries(mylib PUBLIC otherlib)

add_executalbe(main main.cpp)
target_link_libraries(main PUBLIC mylib)
```
- 原因: 将static链接到share上，static_lib 的地址是**不变**的，而share的地址是**变化**的
- Solution:  
	1. 生成对象库
	2. 让静态库编译时也生成与**位置**无关的PIC, 这样才能装在动态库里
	```cmake
	set(CMAKE_POSITION_INDEPENDENT_CODE ON) # 开启
	
	add_library(otherlib STATIC otherlib.cpp)

	add_library(mylib SHARED mylib.cpp)
	target_link_libraries(mylib PUBLIC otherlib)

	add_executable(main main.cpp)
	target_link_libraries(main PUBLIC mylib)
	```
	3. 只针对某一个库生成 `PIC` (位置无关代码)
	```cmake
	add_library(othrelib STATIC otherlib.cpp)
	set_property(TARGET otherlib PROPERTY POSITON_INDEPENDENT_CODE ON)
	add(...)
	link(..)
	...
	```

	

### 对象库
- 保证不会自动剔除没引用的文件
 // TODO
 
---
## 3. 链接第三方库

### 1. 直接链接
在  windows 下可能无法找到
```cmake
add_executable(main main.cpp)
target_link_libraries(mian PUBLIC tbb)
target_link_libraries(mian PUBLIC C:/lib/...)
```
### 2.  更好的方式： `find_package()`
```cmake
add_executable(main main.cpp)

find_package(TBB REQUIRED)
target_link_libraries(main PUBLIC TBB:tbb)
```
`.cmake` 文件由作者提供, 否则需要自己写来进行find
![](attachments/Pasted%20image%2020220902232224.png)
![](attachments/Pasted%20image%2020220902232313.png)

### 3. 使用 vcpkg
```cmake
-DCMAKE_TOOLCHAIN_FILE=<vcpkg_dir>/scripts/buildsystems/vcpkg.cmake
```
- 使用 set() 需要放在 project()之前

---
## 4. 输出

- message(STATUS ...) 带 `--` 前缀的信息
- message(WARNNING ) 
- message(AUTHOR_WARNING) 只有作者能看到的警告
- message(FATAL_ERROR .. ) 红色并且立即终止程序
- message(SEND_ERROR ..) 不终止程序的错误

## 5. 缓存
- build 目录下的文件是缓存的，有时候环境变量但他没变，需要删掉重来
- 缺点 : `.o` 文件也会被删除

- 自己设置缓存
```cmake
set(myvar "hello" CACHE STRING "this is a docstirng in cache(comment)")
```

- 命令行太麻烦, 可以通过 `ccmake -B build` 来编辑缓存变量
- `opthon()` 中设置的变量可以通过ccmake看见

![](attachments/Pasted%20image%2020220903000006.png)

## 6. 控制流
- 不需要加`${}
```cmake
set(MYVAR Hello)
if(MYVAR MATCHES "Hello")
	message("MYVAR is Hello")
else()
	message("MYVAR is not Hello")
endif()
```
![](attachments/Pasted%20image%2020220902234936.png)
- 在 `${MYVAR}` 外加`""`

- 判断变量是否存在
```cmake
if(DEFINED ENV{xx}) # 不需要 `$` 符号
```

## 7.  变量与作用域
### 1. 子模块向父模块传递变量
- 父
```cmake
set(MYVAR OFF)
add_subdirector(mylib)
message("MYVAR: ${MYVAR}")
```
- 子
```cmake
set(MYVAR ON PARENT_SCOPE)
```
结果为ON

### 2. 访问环境变量
```cmake
message("PATH is ： $ENV{PATH}")
```

### 3. 访问缓存里的变量
```cmake
message("CMAKE_BUILD_TYPE is: $CACHE{CMAKE_BUILD_TYPE}")
```


---
## 8. -D 附加参数

### 1. CMAKE_BUILD_TYPE 参数
- `Debug`: 完全不优化, 便于调试   `-O0 -g`
- `Release`: 优化程度高，但编译慢 `-O3 -DNDEBUG`
- `MinSizeRel`: 最小体积发布，比 Release 小，但是不完全优化，减少了二进制文件的体积 `-Os -DNDEBUG`
- `RelWithDebInfo`: 带调试信息发布，比 Release 还大, `-O2 -g -DNDEBUG`
- 默认参数为空， 相当于 Debug

>此外定义了 `NDEBUG` 宏回事 `assert` 被去除掉

#### 设置默认 Release
- 如果不想指定 `-D CMAKE_BUILD_TYPE....`  参数， 或者忘记指定
- 可以判断参数有无（默认不指定即为**空串**）
```cmake
if (NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE Release)
endif()
```
### 2. 指定编译器
```CMake
$ cmake -D CAMKE_C_COMPILER=...
$ cmake -D CAMKE_CXX_COMPILER=...
```


---
## 9. 常用变量
-  路径与项目名称
 `PROJECT_SOURCE_DIR` : 当前源码路径
 `PROJECT_BINARY_DIR` : out/put/path
 `
 `CMAME_SOURCE_DIR` : 根项目源码路径 但 (最外层CMAKELIST.txt 文件的父目录)
 `CMAKE_BINARY_DIR` : 根项目输出路径
 `
 `PROJECT_IS_TOP_LEVEL` : BOOL 类型， 表示当前项目是否是最顶层的根项目
 
 `PROCECT_NAME` : 当前项目名
 `CMAKE_PROJECT_NAME` : 根项目名

-  [设置 CMAKE_CXX_STANDARD 标准](#设置%20CMAKE_CXX_STANDARD%20标准)
-  [ VERSION 字段](#2%20VERSION%20字段)
-  系统变量
	- WIN32
	- APPLE
	- UNIX
	- ANDROID
	- IOS
![](attachments/Pasted%20image%2020220902234215.png)

- 其他
```cmake
CMAKE_BUILD_TOOL  #指定构建工具(VS6-msdev Unix-make/gmake VS7-devenv Nmake-nmake)
CMAKE_DL_LIBS #包含 dlopen 和 dlclose 的库名称
CMAKE_COMMAND #指向 cmake full-path 
CMAKE_EDIT_COMMAND # cmake-gui 或 ccmake 的 full-path
CMAKE_EXECUTALE_SUFFIX # 该聘任太上可执行程序的后缀
CMAKE_SIZEOF_VOID_P # void 指针的大小
CMAKE_SKIP_PATH # 如果为真，不添加运行时的路径信息
CMAKE_GENRATOR # -G 参数内容
```

---
## 10. 常用函数

### 1. project()
```cmake
project(项目名 LANGUAGES 使用的语言**列表**)
```
#### 1. LANGUAGE 字段
- C
- CXX
- ASM
- Fortran
- CUDA : 英伟达的 CUDA (after 3.8)
- OBJC
- OBJCXX : Objective-C++ (after 3.18)
- ISPC: 一种 intel 的自动 SIMD 语言 （after 3.18)

> 如果不指定默认为 C 和 CXX
    或者使用 `enable_language()` 在后面启用语言

#### 2. VERSION 字段
- 可通过四个变量获取
```cmake
project(hello VERSION 0.2.3)

message("PROJECT_VERSION: ${PROJECT_VERSION}")
message("PROJECT_VERSION_MAJOR: ${PROJECT_VERSION_MAJOR}")
message("PROJECT_VERSION_MINOR: ${PROJECT_VERSION_MINOR}")
message("PROJECT_VERSION_PATCH: ${PROJECT_VERSION_PATCH}")
```
- 通过项目名变量**嵌套**来获取版本
```cmake
message("hello_VERSION: ${${PROJECT_NAME}_VERSION} ")
message("hello_SOURCE_DIR: ${${PROJECT_NAME}_SOURCE_DIR} ")
message("hello_BINARY_DIR: ${${PROJECT_NAME}_BINARY_DIR} ")
```
---
### 2. set() 

#### 1. 设置 CMAKE_CXX_STANDARD 标准
```cmake
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON) #检测到不支持时出错
set(CMAKE_CXX_EXTENSIONS ON) #一般设为off， 不然在msvc上 没有特性出错
```

#### 2. 设置 变量的默认值方式
```cmake
if(NOT DEFINED BUILD_SHARE_LIBS)
	set(BUILD_SHARED_LIBS ON)
endif()
```

#### 3. 帮助 clangd 识别项目
- [ 设置 include path](../../Frame/LLVM/Clangd.md#1%20设置%20include%20path)

---

### 3. set_property()
- 设置单个lib属性 [坑点：动态库无法链接静态库](#坑点：动态库无法链接静态库)
- 其他
```cmake
set_property(TAGET main PROPERTY CXX_STANDARD 17)
set_property(TAGET main PROPERTY CXX_STANDARD ON)
set_property(TAGET main PROPERTY WIN32_EXECUTALBLE ON) # 在windows中关闭 console 只有 gui (default OFFu)
set_property(TAGET main PROPERTY LINK_WHAT_YOU_USE ON) # 告诉编译器不要自动剔除没有引用符号的链接库 （default OFF)
set_property(TAGET main PROPERTY LIBRARY_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib) # 动态链接库的输出路径
set_property(TAGET main PROPERTY ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib) # 静态链接库
set_property(TAGET main PROPERTY RUNTIME_OUTPUT_DIRECTORY ${CMAKE_SOURCE_DIR}/lib) # 可执行文件
```

### 4. set_target_property()
- 可以批量设置属性
 ![](attachments/Pasted%20image%2020220902230759.png)

### 5. find_package()
- [ 更好的方式： find_package](#2%20更好的方式：%20find_package)

### 6. add_custom_target()
创建一个 run 伪目标，执行 main 的可执行文间
```cmake
add_executable(main main.cpp)

add_custom_target(run COMMAND $<TARGET_FILE:main>) # 使得 run 依赖于 main
or
add_dependencies(run main)
```

这样就可以运行指定目标了
```shell
cmake -build build --target run
```


