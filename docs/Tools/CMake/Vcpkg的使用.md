# CMake 使用 Vcpkg 安装的包, Include 和 lib 连接

## 1. 打开 integrate
（可选）打开后，在VS中就可以直接include与调用
![](attachments/Pasted%20image%2020220910170214.png)

## 2. 设置vcpkg.cmake的路径
```cmake
cmake .. -D CMAKE_TOOLCHAIN_FILE="/path/to/vcpkg/scripts/buildsystems/vcpkg.cmake"
```
或者在 `CMakelist.txt` 中：
```cmake
set(CMAKE_TOOLCHAIN_FILE "D:/Program\ Files/vcpkg/vcpkg/scripts/buildsystems/vcpkg.cmake")
```
**注意**: 需要写在 project() 之前

## 3.  查找包与包含头文件
(Find Package and Include Directories)
> 在find_package() 后， cmake 并不会自动添加include 文件夹，需要我们手动添加

```cmake
find_package(<package_name> CONFIG REQUIRED)

find_path(package_INCLUDE_DIR NAMES <xxx.h> PATH_SUFFIX <dir_name>
```
- `xxx.h` 文件夹下包含的某一个文件
- `dir_name`  xxx.h 存在的文件夹， 即 path_suffix
例如:
```cmake
find_package(TBB CONFIG REQUIRED)
#find_package(TBB)
message("${tbb_DIR}") 
#输出： D:/Program Files/vcpkg/vcpkg/installed/x64-windows/share/tbb


find_path(tbb_INCLUDE_DIR NAMES tbb.h PATH_SUFFIX tbb)
include_directories(${tbb_INCLUDE_DIR})
message("${tbb_INCLUDE_DIR}")
#输出: D:/Program Files/vcpkg/vcpkg/installed/x64-windows/include
```

查到到的就是`tbb.h` 存在的文件 path 去掉 `tbb` 后缀的路径，然后就可以直接include了
```cpp
#include <tbb/tbb.h>
```


## 4. 连接库
(link libraries)

```cmake
find_package(package)
link_libraries(${PROJECT_NAME} package)
```
**注意** : 在 `find_library()` 要注意查找的包名, 使用vcpkg调用时会提醒如何寻找与连接
![](attachments/Pasted%20image%2020220910174638.png)
如果包名错误，将无法连接

