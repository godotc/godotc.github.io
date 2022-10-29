# Freestanding

- 程序一般编译为基于宿主环境的elf，再调用如linux的系统调用完成的
- freestanding 不依靠于宿主环境

## qemu
-  0x10000000 是 quemu-system-riscv virt机器模型的串口地址
```c
#include <stdint.h>

void _start() {
  volatile uint8_t *p =
	   (uint8_t *)(uintptr_t)0x10000000;
  *p = 'A';
  while (1) ;
}
```

```sh
riscv64-linux-gnu-gcc -ffreestanding -nostdlib -Wl, -Ttext=0x80000000 -O2 a.c

qemu-system-riscv64 -nographic -M virt -bios none -kernel a.out
```

- 如何结束运行？
- 没有操作系统无法 C-c C-d
- 再virt 模型中， 在一个奇特的地址写入一个安好即可
```c
volatitle uint32 *exit = (uint32_t*)(uintptr_t)0x100000;
*exit = 0x5555; // magic number
_start(); //递归调用
```