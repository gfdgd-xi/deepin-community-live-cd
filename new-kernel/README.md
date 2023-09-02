# Deepin Community Live CD New Kernel 系列仓库
## 请注意：升级内核有风险！！！！！！！！如无必要不建议升级！！！！！
> 地址：http://kernel.dclc.gfdgdxi.top
## 只加源
```bash
wget http://kernel.dclc.gfdgdxi.top/sources/github.sh ; bash github.sh ; rm github.sh
```
### 加源后如何安装？
```bash
sudo apt update
sudo apt install linux-kernel-dclc-gfdgdxi
```
## 镜像
此镜像属于 Deepin Community Live CD 系列（Deepin Community Live CD 简称为 DCLC，Deepin Community Live CD 是什么？传送门：https://bbs.deepin.org/post/242933），New Kernel 系列镜像旨在可以更简单的安装和更新高版本内核  
New Kernel 系列提供了基于 Deepin 15.11、Deepin 20.9、Deepin 23 Beta 的系统安装镜像  
### 效果图

![图片.png](https://storage.deepin.org/thread/202306231710268431_图片.png)

![图片.png](https://storage.deepin.org/thread/202306231717332184_图片.png)

![图片.png](https://storage.deepin.org/thread/202306231713015468_图片.png)  

### 此系列区分

此系列还有以下两个小的版本

#### 普通版（deepin 15、20、23）

就改了系统内核，无其他大的变动

#### 预装常用软件的版本（deepin 20、23）

在普通版的基础上，移除了 LibreOffice 并安装了星火应用商店、Wine运行器、QQ等常见应用程序  
（23版还添加了 Better DDE，但23的体积真太大了，也塞不下什么东东）

![图片.png](https://storage.deepin.org/thread/202306231720596049_图片.png)

![图片.png](https://storage.deepin.org/thread/202306231714168384_图片.png)

### 下载链接
123 云盘：https://www.123pan.com/s/pDSKVv-yRpWv  
seafile：http://seafile.jyx2048.com:2345/deepin-community-live-cd/iso/  
项目地址：https://github.com/gfdgd-xi/dclc-kernel/  


## 如何提交 DEB（PR）
往仓库根目录创建一个以版本号+特殊后缀（特殊后缀可加可不加），然后包名不得与现有 deb 包冲突  

## 鸣谢名单
### 提供内核
| 内核版本 | 提供用户 |
| :-: | :-: |
| 6.3.5-1、6.3.6、6.3.7、6.3.8、6.4.0-rc4、6.4.0-rc5 | [.](https://bbs.deepin.org/user/297983) |

## ©2022~2023 gfdgd xi
