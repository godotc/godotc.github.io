# 安装YouCompleteMe
>https://github.com/ycm-core/YouCompleteMe/wiki/Full-Installation-Guide

1. git clone url --depth 1 (指定深度, 避免克隆冗余数据)
2. git submodule update --recursive --init --depth 1 (同上)
3.  python3 init.py --all/{--go.. , --Java.. } --verbose

--- 

- 直接使用 Vundle 添加一行plugin