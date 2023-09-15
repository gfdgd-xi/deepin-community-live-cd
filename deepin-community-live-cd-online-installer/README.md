# Deepin Community Live CD 在线系统安装工具
Deepin Community Live CD 在线安装工具是一个能在 Live CD 上自动从互联网获取系统安装包安装系统的工具  
目前支持安装 Debian  
该程序依照 GPLV3 开源

## 编译方法
```bash
sudo apt install qt5-default git make
git clone https://gitee.com/gfdgd-xi/deepin-community-live-cd-online-installer
cd deepin-community-live-cd-online-installer
qmake .
make -j4
```

## ©2022~Now gfdgd xi