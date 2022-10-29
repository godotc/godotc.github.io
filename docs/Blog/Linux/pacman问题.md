1. 安装软件包损坏,
>File /bin/pacman/.pkg.python-pip is corrupted (invalid or corrupted package (PGP signature)).Do you want to delete it? [Y/n]
- 更新密匙
```bash
pacman-key --refresh-keys
pacman -S archlinux-keyring
```
- 更新源
```bash
pacman -Ssy 
```