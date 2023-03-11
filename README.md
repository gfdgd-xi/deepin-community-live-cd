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

### Deepin Community Live CD 1.4.0——基于20.7，新增Ghost（非 Install 版）
1、升级为基于 20.7，支持最新的 5.18.4-amd-desktop-hwe 内核  
2、修复星火源签名问题（且换成镜像源以提高安装速度）  
3、新增 15.11 版本  
![image.png](https://storage.deepin.org/thread/202209112148168591_image.png)

![image.png](https://storage.deepin.org/thread/202209112150178582_image.png)

![image.png](https://storage.deepin.org/thread/202209112151255384_image.png)

### Deepin Community Live CD 1.3.0——优化 Full 版体积、制作方式、应用商店（非 Install 版）
1、优化制作方式，由原来基于安装后的系统进行设置打包改为直接基于安装镜像的系统进行修改，保留更多驱动  
2、更新里面自带的应用商店（之前版本的应用商店有 bug 实际是基本无法安装任何应用的），也从原来把应用列表写入到代码到从云端获取  

![image.png](https://storage.deepin.org/thread/202207241542372205_image.png)

![image.png](https://storage.deepin.org/thread/202207241542501598_image.png)

![image.png](https://storage.deepin.org/thread/202207241543067425_image.png)

![image.png](https://storage.deepin.org/thread/202207241543211351_image.png)
3、缩小体积，成功做到小于 2GB

![image.png](https://storage.deepin.org/thread/202207241544299757_image.png)

### Deepin Community Live CD 1.2.1——自带“高级”QQ（有 Install 版）
1、在 mini、full、install 版本预装了 QQ For Linux

![VirtualBox_Live CD Test_01_07_2022_20_06_19.png](https://storage.deepin.org/thread/202207012008353300_VirtualBox_LiveCDTest_01_07_2022_20_06_19.png)
2、在 mini、install 版本预装了 todesk  
![VirtualBox_Live CD Test_01_07_2022_20_24_01.png](https://storage.deepin.org/thread/202207012024198047_VirtualBox_LiveCDTest_01_07_2022_20_24_01.png)
3、修改了 install 的 deepin-installer 脚本，使用此版本的系统安装向导安装到的应用将会自动移除一些 Live CD 预装的应用  

### Deepin Community Live CD 1.2.0 归来——支持运行官方安装程序安装（有 Install 版）
1. 将系统版本升级到 deepin 20.6，将内核升级到 5.10.101、5.15.34
2. 支持多内核选择启动（只限 full/install 版本）
3. 优化了镜像结构，显示多菜单以及UEFI 启动支持显示背景图片以及支持倒计时（只限 full/install）
4. 对 full 版本进行二次精简
5. 添加了 install 版本
6. 升级了 Pardus Boot Repair 应用，删除了full版的系统安装程序
![VirtualBox_UOS_03_06_2022_17_53_31.png](https://storage.deepin.org/thread/202206031934148338_VirtualBox_UOS_03_06_2022_17_53_31.png)
![VirtualBox_UOS_03_06_2022_17_55_02.png](https://storage.deepin.org/thread/202206031934142598_VirtualBox_UOS_03_06_2022_17_55_02.png)

### Deepin Community Live CD 1.1.0——支持本地安装启动（非 Install 版）
1. 更新了镜像的内核，升级到了 5.15.24
2. 支持安装 deb 包从本地启动（但暂时不支持设置密码）
   ![image.png](https://storage.deepin.org/thread/202205081525523045_image.png)

### Deepin Community Live CD 1.0.5（非 Install 版）
1. 给这个小型的应用商店添加了点应用
2. 添加了 Grub Customizer
   ![VirtualBox_Live CD Test_16_04_2022_21_05_30.png](https://storage.deepin.org/thread/202204162105452286_VirtualBox_LiveCDTest_16_04_2022_21_05_30.png)
3. 初步添加了一个在线的系统安装程序（此非常规方法安装，只支持 Legary 启动的 PC，***建议不要在工作机上浪***）
   ![VirtualBox_Live CD Test_16_04_2022_21_05_06.png](https://storage.deepin.org/thread/202204162105534467_VirtualBox_LiveCDTest_16_04_2022_21_05_06.png)

### Deepin Community Live CD 1.0.4（非 Install 版）
1. 添加了一个小型的应用商店以便安装一些东西
   ![image.png](https://storage.deepin.org/thread/202204111536364147_image.png)
2. 添加了星火应用商店的应用源
3. 将 GParted 的版本升级到了 1.0.0
   ![image.png](https://storage.deepin.org/thread/202204111537524078_image.png)
4. 更换了桌面壁纸（Grub壁纸暂时因为比例问题，所以没有换）感谢 [@PossibleVing](user/225373) 提供的壁纸
   ![deepin-live_01.jpg](https://storage.deepin.org/thread/202204111536082433_deepin-live_01.jpg)
5. 删除旧内核的一些残留文件
6. 添加了深度备份还原工具
   ![image.png](https://storage.deepin.org/thread/20220411153527563_image.png)

### Deepin Community Live CD 1.0.3（非 Install 版）

1. 将系统版本升级到 deepin 20.5，将内核升级为 5.10.101-amd64-desktop
2. 修改了 dde 包，进一步精简应用（精简了日历、系统帮助、打印管理器）

![VirtualBox_deepin_04_04_2022_09_04_53.png](https://storage.deepin.org/thread/202204040905067822_VirtualBox_deepin_04_04_2022_09_04_53.png)

![VirtualBox_deepin_04_04_2022_09_03_51.png](https://storage.deepin.org/thread/202204040904178154_VirtualBox_deepin_04_04_2022_09_03_51.png)

### Deepin Community Live CD 1.0.2（非 Install 版）

1、修复终端自动填充和主题失效以及关机提示“unattended-upgrades”正在运行需要强制关机的问题  
![image.png](https://storage.deepin.org/thread/202203271939103640_image.png)

2、添加应用Pardus Boot Repair和PowerISO  
![image.png](https://storage.deepin.org/thread/202203271938508076_image.png)
3、删除了应用“深度软件包安装器”  
4、设置了 root 密码以及设置 pkexec 无需输入密码即可获取权限  
5、设置为默认关闭窗口特性，可以自行在设置中打开   

![image.png](https://storage.deepin.org/thread/202203272006262305_image.png)

### Deepin Community Live CD 1.0.1（非 Install 版）
1. 添加应用 todesk、Live CD 工具
2. 设置 root 密码为 123456
![QQ图片20220320121731.png](https://storage.deepin.org/thread/202203201903312433_QQ图片20220320121731.png)  
![截图_dde-desktop_20220320191233.png](https://storage.deepin.org/thread/202203201917084078_截图_dde-desktop_20220320191233.png)

### Deepin Community Live CD 1.0.0（非 Install 版）

![QQ图片20220320121731.png](https://storage.deepin.org/thread/202203201417332081_QQ图片20220320121731.png)  
![截图_选择区域_20220320122733.png](https://storage.deepin.org/thread/202203201230103237_截图_选择区域_20220320122733.png)  

![截图_dde-desktop_20220320124833.png](https://storage.deepin.org/thread/202203201249349106_截图_dde-desktop_20220320124833.png)

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
