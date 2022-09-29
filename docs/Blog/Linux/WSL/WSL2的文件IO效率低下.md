# WSL2 的文件 I/O 效率过低问题

## 1. 前言
>系统环境:
>- windows 11
>- wsl2
>- archlinux-wsl
>- i5-9400h

最近使用 vscode 远程连接 wsl2 进行**工程项目**开发，使用 `clangd` 插件进行语法检测与补全。但是在补全时候发现了有明显的迟钝，在输入字符后，具有两秒左右的延迟。
据了解是 wsl2 采用了 Hyper-v 技术 以更深程度的虚拟化提供了更完整的linux内核，但是造成了文件系统之间 I/O 的问题:
![](attachments/Pasted%20image%2020220912135345.png)

通常使用 wsl 来当作开发与测试环境，不会要求太高的性能。但是对于使用 vscode 远程连接进行项目开发造成了非常不好的体验。

## 2. 方案比选
wsl1 拥有跨文件系统的性能，于是对几种方案的结果做了对比，以 `clangd` 插件的 log 输出中的 `reply:textDocument/codeAction` 调用返回延迟为例:

1. `wsl2`
延迟在 1900~2500 ms 之间，两秒左右的延迟

2. 直接访问 `\\wsl$` 进行操作
延迟在 900~1100ms 之间, 但是插件运行环境环境为Windows, 无法补全 unix 系统中的库

3. 转换为 `wsl1` 后
延迟在 100~200 ms 之间，对比 `wsl2` 性能有差不多10倍多的提升，补全几乎感觉不到卡顿, 

## 3. 如何切换切换 wsl 的版本
- 查看当前wsl版本
```bash
$ wsl -l --verbose 
```
- 切换子系统的 wsl 版本为 1
```bash
# wsl --set-version <distribute> <version>
$ wsl --set-version arch 1  
```
随后，会消耗一定时间来进行版本转换，成功后就能发现显著的 I/O 性能的提升了
 ![](attachments/Pasted%20image%2020220912141909.png)