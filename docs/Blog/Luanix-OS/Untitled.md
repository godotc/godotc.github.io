## 1. 构建编译工具链
https://github.com/Minep/lunaix-os#appendix2
## 2. First make
1.  `multiboot.h` --> `boot.S`
2.  `kernel.c`
3. `tty.h` --> `tty.c`
4. 自定义 connector (link.ld) --> make sure multiboot in specific __ position.

- patsubst 
	- 替换文件后缀
	- $(patsubst src, dest, file_list)
5. add  `makefile` `GRUB_TEMPLATE`  `config-grub.sh`  
6. first make
	- ld: cannot fint `-lc` and `crt0.o`
	// TODO