## Vscode 插件

### 1. 设置 include path 
---
- ABANDONED
1. create `.clangd` file in project root
2. add `CompileFlags`:
```yml
CompileFlags:                     # Tweak the parse settings
 Add:
	- "-I=[include_path]"    # include conffig
	or
	- "--include-dir=[include_path]"
  #Add: [-xc++, -Wall]             # treat all files as C++, enable more warnings
  #Remove: -W*                     # strip all other warning-related flags
  #Compiler: clang++               # Change argv[0] of compile flags to `clang++`
```
---
- Right Way
see as: https://clangd.llvm.org/installation.html

Add **FLAG** When create build and cmake :
```shell
mkdir build && cd build
cmake .. -D CMAKE_COMPILE_COMMANDS=1 ...
ln -s compile_commands.json ../
```

Or set in cmakelists.txt:
```cmake
set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
```

## 2. Clangd Arguments
```json
   "clangd.arguments": [
        "--completion-style=bundled", // bundled 补全打包为一个建议, 相反为 detailed
        "-j=8",
        "--background-index", // 后台自动分析文件(compile_commands)
        "--clang-tidy",
        "--pretty", // 美化输出的json
        "--cross-file-rename", // 跨文件重命名变量
        "--function-arg-placeholders=false", // 启用这项时，补全函数时，将会给参数提供占位符，键入后按 Tab 可以切换到下一占位符，乃至函数末
    ]
```

