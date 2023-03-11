# Deepin Community Live CD
## 非 Install 版介绍
> deepin 发布的 Live CD 有点古老，功能有少许不全，在部分新电脑是无法启动，对 ventoy 兼容性不是很好，同时我也想自己定制一个属于自己的 Live CD，于是这个 Live CD 就出现了  
> 旧版 Live CD：  
> ![image.png](https://storage.deepin.org/thread/202203201424371318_image.png)  
> ![image.png](https://storage.deepin.org/thread/202203201425394425_image.png)  

此 Live CD 基于 deepin 20.8 和原 Live CD 2.0 制作，安装部分维护工具（如果还有需要添加的就说），感谢 [https://bbs.deepin.org/post/166409](https://bbs.deepin.org/post/166409) 的作者 [@xchngg](https://bbs.deepin.org/user/108842)的参考文档，本 Live CD 1.2.1 及以前版本使用该方案打包，测试 Ventoy 在 Legacy 和 UEFT 模式下均可运行此 Live CD，有常用驱动（网卡、显卡、声卡），理论上能运行 deepin 20.6 均可运行  
同时也借鉴了以下文章的内容：  
[https://bbs.deepin.org/post/228930](https://bbs.deepin.org/post/228930) [@deepin-superuser](user/278484)  

[https://bbs.deepin.org/post/228568](https://bbs.deepin.org/post/228568)  [@木一明](user/160805)  

**install、full 用户密码（包括root密码）为：123456**  
**tiny、mini root 密码未知**  

![image.png](https://storage.deepin.org/thread/202209112148168591_image.png)

![image.png](https://storage.deepin.org/thread/202209112150178582_image.png)

![image.png](https://storage.deepin.org/thread/202209112151255384_image.png)

## Install 版介绍
这个镜像是接着 Deepin Community Live CD 系列的（Deepin Community Live CD 简称为 `DCLC`，Deepin Community Live CD 系统是什么？传送门：https://bbs.deepin.org/post/242933） ，自然此镜像会同时拥有原 Deepin Community Live CD 的功能和系统安装功能  
也为了简化安装后的操作，会预装一些软件以及一些配置等等  
***注意：这个和鸿玩并不一样，不会修改任何有关 deepin 的系统信息，包括但不限于系统版本、系统 logo 等等***  
***且并不是 deepin 的下游发行版，只是一个定制的镜像***  
***Live CD 模式下用户默认密码：123456，root 密码：123456，安装到本地的不受此影响***  

![图片.png](https://storage.deepin.org/thread/202212240937174208_图片.png)

## 更新内容（如无特殊注明则代表是非 Install 版）
### Deepin Community Live CD Install 版 1.7.0—基于20.8的安装镜像，预装星火4.0

1. 跟进系统版本为 20.8
2. 更新预装的星火应用商店和 Wine 运行器版本，星火应用商店版本号：4.0.1，Wine 运行器版本号：3.0.0.1-uos
3. 开始选择性安装 UEngine 安卓环境和 UEngine 运行器（若不想安装，可以通过断网或在体验模式下打开添加自定义脚本进行修改）

![图片.png](https://storage.deepin.org/thread/202212240941481968_图片.png)

![图片.png](https://storage.deepin.org/thread/202212240941227743_图片.png)
### Deepin Community Live CD 1.7.0——跟进新版Deepin20.8、LinuxQQ（非 Install 版）
#### Mini 版
1. 更新 QQ For Linux 至镜像封装时最高版本  
#### Full 15.11 版
1. 更新 QQ For Linux 至镜像封装时最高版本
2. 更新了部分 apt 源内更新内容
#### Full 版
1. 更新 QQ For Linux 至镜像封装时最高版本
2. 跟进 Deepin 20.8 更新内容

### Deepin Community Live CD Install 1.6.0——更加定制化的的安装镜像
1. 新增 boot repair、Ghost
2. 有添加用户定制自定义脚本的小工具
   
![image.png](https://storage.deepin.org/thread/202211091020099456_image.png)

### Deepin Community Live CD Install 1.5.0——一个定制的系统安装镜像
![image.png](https://storage.deepin.org/thread/202210231137072181_image.png)

![image.png](https://storage.deepin.org/thread/202210231147038996_image.png)

![image.png](https://storage.deepin.org/thread/202210231157439386_image.png)

![image.png](https://storage.deepin.org/thread/202210231157552632_image.png)

![image.png](https://storage.deepin.org/thread/202210231158032520_image.png)

## 更多软件
[![gfdgd xi/Wine 运行器](https://gitee.com/gfdgd-xi/deep-wine-runner/widgets/widget_card.svg?colors=4183c4,ffffff,ffffff,e3e9ed,666666,9b9b9b)](https://gitee.com/gfdgd-xi/deep-wine-runner)   
[![gfdgd xi/uengine 运行器](https://gitee.com/gfdgd-xi/uengine-runner/widgets/widget_card.svg?colors=4183c4,ffffff,ffffff,e3e9ed,666666,9b9b9b)](https://gitee.com/gfdgd-xi/uengine-runner)   
[![gfdgd xi/Deepin Community Live CD](https://gitee.com/gfdgd-xi/deepin-community-live-cd/widgets/widget_card.svg?colors=4183c4,ffffff,ffffff,e3e9ed,666666,9b9b9b)](https://gitee.com/gfdgd-xi/deepin-community-live-cd)   
[![gfdgd xi/国产 CPU 应用分享站](https://gitee.com/gfdgd-xi/apt-packages-websize-program/widgets/widget_card.svg?colors=4183c4,ffffff,ffffff,e3e9ed,666666,9b9b9b)](https://gitee.com/gfdgd-xi/apt-packages-websize-program)   
[![gfdgd xi/简易远程桌面访问器](https://gitee.com/gfdgd-xi/simple-remote-desktop-accessor/widgets/widget_card.svg?colors=ffffff,ffffff,,e3e9ed,666666,9b9b9b)](https://gitee.com/gfdgd-xi/simple-remote-desktop-accessor)   
[![星火社区作品集/星火应用商店（控制台版）](https://gitee.com/spark-community-works-collections/spark-store-console/widgets/widget_card.svg?colors=4183c4,ffffff,ffffff,e3e9ed,666666,9b9b9b)](https://gitee.com/spark-community-works-collections/spark-store-console)   
[![星火社区作品集/spark-webapp-runtime 运行器](https://gitee.com/spark-community-works-collections/spark-webapp-runtime-runner/widgets/widget_card.svg?colors=4183c4,ffffff,ffffff,e3e9ed,666666,9b9b9b)](https://gitee.com/spark-community-works-collections/spark-webapp-runtime-runner)   
[![gfdgd xi/定时器](https://gitee.com/gfdgd-xi/timer/widgets/widget_card.svg?colors=4183c4,ffffff,ffffff,e3e9ed,666666,9b9b9b)](https://gitee.com/gfdgd-xi/timer)   

## ©2022-Now gfdgd xi、为什么您不喜欢熊出没和阿布呢 
