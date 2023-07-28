# Deepin Community Live CD  
## 介绍
Deepin Community Live CD 是一个让用户能够在系统出现问题时进行临时的维护和工作的镜像，预装了较为常用的维护工具，部分安装镜像还带系统安装功能。  

## 系列划分
### 不支持系统安装功能的系列（Tiny、Mini、Full、Full-15.11、Debian、Debian-Core）
#### Tiny（amd64）
在 Deepin 官方的 Deepin Live CD 2.0 的基础上修改而来，只更新了镜像内核（使用 `dde15` 桌面环境）  
![](https://storage.deepin.org/thread/202209112201077726_image.png)  
![](https://storage.deepin.org/thread/202205081542284615_VirtualBox_deepinlivecdTest_08_05_2022_15_42_04.png)  
![](https://storage.deepin.org/thread/202205081536449227_VirtualBox_deepinlivecdTest_08_05_2022_15_36_25.png)  
![](https://storage.deepin.org/thread/202209112203025802_image.png)  
#### Mini（amd64）
在 Tiny 的基础上增加了一些维护软件（使用 `dde15` 桌面环境）  
![image.png](https://storage.deepin.org/thread/202209112158229271_image.png)

![VirtualBox_Live CD Test_01_07_2022_20_19_56.png](https://storage.deepin.org/thread/20220701202418495_VirtualBox_LiveCDTest_01_07_2022_20_19_56.png)

![VirtualBox_Live CD Test_01_07_2022_20_24_01.png](https://storage.deepin.org/thread/202207012024198047_VirtualBox_LiveCDTest_01_07_2022_20_24_01.png)
![image.png](https://storage.deepin.org/thread/202209112200295894_image.png)

![VirtualBox_Live CD Test_01_07_2022_20_22_23.png](https://storage.deepin.org/thread/202207012024191528_VirtualBox_LiveCDTest_01_07_2022_20_22_23.png)
![VirtualBox_Live CD Test_01_07_2022_20_20_24.png](https://storage.deepin.org/thread/202207012024185466_VirtualBox_LiveCDTest_01_07_2022_20_20_24.png)  
#### Full（amd64）
基于 Deepin 20，预装了一些常用的维护软件（使用 `dde20` 桌面环境）  
![image.png](https://storage.deepin.org/thread/202209112148168591_image.png)

![image.png](https://storage.deepin.org/thread/202209112150178582_image.png)

![image.png](https://storage.deepin.org/thread/202209112151255384_image.png)  
#### Debian-Core（amd64、arm64）
基于 Debian，没有 GUI  

![Screenshot_qemu_20230728120451.png](https://storage.deepin.org/thread/202307281231432359_Screenshot_qemu_20230728120451.png)

#### Debian（amd64、arm64）
在 Debian-Core 的基础添加了桌面环境并预装常用维护软件（使用 `xfce4` 桌面环境）
#### Full-15.11（停止维护）（amd64）
基于 Deepin 15.11 制作，预装一些常用维护软件  
![image.png](https://storage.deepin.org/thread/202209112153411297_image.png)

![image.png](https://storage.deepin.org/thread/202209112155289267_image.png)

![image.png](https://storage.deepin.org/thread/202209112157046137_image.png)


### 支持系统安装功能的系列（Install、New Kernel）
#### Install（amd64）
基于 Deepin 20，在预装 Live 模式下常用的维护软件的基础上，新增了系统安装程序并预装一些常用软件  
![VirtualBox_Live CD Test_01_07_2022_20_26_44.png](https://storage.deepin.org/thread/202207012027242790_VirtualBox_LiveCDTest_01_07_2022_20_26_44.png)

![VirtualBox_Live CD Test_01_07_2022_20_15_47.png](https://storage.deepin.org/thread/202207012015595089_VirtualBox_LiveCDTest_01_07_2022_20_15_47.png)
![VirtualBox_Live CD Test_01_07_2022_20_17_13.png](https://storage.deepin.org/thread/202207012017254728_VirtualBox_LiveCDTest_01_07_2022_20_17_13.png)
![VirtualBox_Live CD Test_01_07_2022_20_18_48.png](https://storage.deepin.org/thread/202207012018581211_VirtualBox_LiveCDTest_01_07_2022_20_18_48.png)
#### New Kernel（amd64）
基于 Deepin 15/20/23，使用更新版本的内核，项目地址：https://github.com/gfdgd-xi/dclc-kernel  
（基于 Deepin 15/20/23）

## Live CD 默认账号和密码（使用 sudo 时均不需要输入密码）
### Tiny
未知
### Mini
未知
### Full
root: 123456  
live: 123456
### Install
root: 123456  
live: 123456  
### Install Kernel
未知
### Debian
root: 123456  
live: 123456  
### Debian-Core
root: 123456

## 历史版本
<table>
<thead>
<tr>
<th align="center">版本号</th>
<th align="center">tiny</th>
<th align="center">mini</th>
<th align="center">full</th>
<th align="center">install</th>
<th align="center">tiny(本地版本)</th>
<th align="center">mini(本地版本)</th>
<th align="center">full(本地版本)</th>
<th align="center">install(本地版本)</th>
<th align="center">15.11</th>
<th align="center">debian_amd64</th>
<th align="center">debian-core_amd64</th>
<th align="center">debian_amd64（本地版本）</th>
<th align="center">debian-core_amd64（本地版本）</th>
<th align="center">debian_arm64</th>
<th align="center">debian-core_arm64</th>
</tr>
</thead>
<tbody>
<tr>
<td align="center">2.0.0（未发布）</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center"></td>
<td align="center">×</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
</tr>
<tr>
<td align="center">1.7.0</td>
<td align="center"></td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.6.0</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.5.0</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.4.0</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center"></td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.3.0</td>
<td align="center"></td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.2.1</td>
<td align="center"></td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.2.0</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center"></td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.1.1</td>
<td align="center"></td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.1.0</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center"></td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center">●</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.0.5</td>
<td align="center"></td>
<td align="center"></td>
<td align="center">×</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.0.4</td>
<td align="center"></td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.0.3</td>
<td align="center"></td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.0.2</td>
<td align="center"></td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.0.1</td>
<td align="center"></td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.0.0-rc</td>
<td align="center"></td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
</tr>
<tr>
<td align="center">1.0.0-beta</td>
<td align="center"></td>
<td align="center"></td>
<td align="center">●</td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
<td align="center"></td>
</tr>
</tbody></table>
  
## 历史版本更新（如无特殊注明则代表是非 Install 版）  
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
  
# ©2022-Now gfdgd xi
