<p width=100px align="center"><img src="icon.svg"></p>
<h1 align="center">Deepin Community Live CD 2.0.0</h1>
<hr>
<a href='https://gitee.com/gfdgd-xi/deepin-community-live-cd/stargazers'><img src='https://gitee.com/gfdgd-xi/deepin-community-live-cd/badge/star.svg?theme=dark' alt='star'></img></a>
<a href='https://gitee.com/gfdgd-xi/deepin-community-live-cd/members'><img src='https://gitee.com/gfdgd-xi/deepin-community-live-cd/badge/fork.svg?theme=dark' alt='fork'></img></a>  

## 介绍
Deepin Community Live CD 是一个让用户能够在系统出现问题时进行临时的维护和工作的镜像，预装了较为常用的维护工具，部分安装镜像还带系统安装功能。  
类似于 Windows PE 的东西  
Deepin Community Live CD QQ 交流群：881201853  
### 支持架构
amd64、arm64
### 下载地址
123云盘：https://www.123pan.com/s/pDSKVv-yRpWv  
百度网盘：链接: https://pan.baidu.com/s/1n5J8M8iqfI-kMbmHfR-x9w 提取码: ejr7  

## 系列划分
### 不支持系统安装功能的系列（Tiny、Mini、Full、Full-15.11、Debian、Debian-Core）
#### Tiny（amd64）
在 Deepin 官方的 Deepin Live CD 2.0 的基础上修改而来，只更新了镜像内核（使用 `dde15` 桌面环境）。  
![](https://storage.deepin.org/thread/202209112201077726_image.png)  
![](https://storage.deepin.org/thread/202205081542284615_VirtualBox_deepinlivecdTest_08_05_2022_15_42_04.png)  
![](https://storage.deepin.org/thread/202205081536449227_VirtualBox_deepinlivecdTest_08_05_2022_15_36_25.png)  
![](https://storage.deepin.org/thread/202209112203025802_image.png)  
#### Mini（amd64）
在 Tiny 的基础上增加了一些维护软件（使用 `dde15` 桌面环境）  
![image.png](https://storage.deepin.org/thread/202209112158229271_image.png)。

![VirtualBox_Live CD Test_01_07_2022_20_19_56.png](https://storage.deepin.org/thread/20220701202418495_VirtualBox_LiveCDTest_01_07_2022_20_19_56.png)

![VirtualBox_Live CD Test_01_07_2022_20_24_01.png](https://storage.deepin.org/thread/202207012024198047_VirtualBox_LiveCDTest_01_07_2022_20_24_01.png)
![image.png](https://storage.deepin.org/thread/202209112200295894_image.png)

![VirtualBox_Live CD Test_01_07_2022_20_22_23.png](https://storage.deepin.org/thread/202207012024191528_VirtualBox_LiveCDTest_01_07_2022_20_22_23.png)
![VirtualBox_Live CD Test_01_07_2022_20_20_24.png](https://storage.deepin.org/thread/202207012024185466_VirtualBox_LiveCDTest_01_07_2022_20_20_24.png) 

#### Full（amd64）
基于 Deepin 20，预装了一些常用的维护软件（使用 `dde20` 桌面环境）。  

![image.png](https://storage.deepin.org/thread/202209112150178582_image.png)

![image.png](https://storage.deepin.org/thread/202209112151255384_image.png)  

#### Debian-Core（amd64、arm64）
基于 Debian，没有 GUI。  

![Screenshot_qemu_20230728120451.png](https://storage.deepin.org/thread/202307281231432359_Screenshot_qemu_20230728120451.png)

#### Debian GUI（amd64、arm64）
在 Debian-Core 的基础添加了桌面环境并预装常用维护软件（使用 `xfce4` 桌面环境）。
#### Full-15.11（停止维护）（amd64）
基于 Deepin 15.11 制作，预装一些常用维护软件。  
![image.png](https://storage.deepin.org/thread/202209112153411297_image.png)

![image.png](https://storage.deepin.org/thread/202209112155289267_image.png)

![image.png](https://storage.deepin.org/thread/202209112157046137_image.png)


### 支持系统安装功能的系列（Install、New Kernel）
#### Install（amd64）
基于 Deepin 20，在预装 Live 模式下常用的维护软件的基础上，新增了系统安装程序并预装一些常用软件。  
![VirtualBox_Live CD Test_01_07_2022_20_26_44.png](https://storage.deepin.org/thread/202207012027242790_VirtualBox_LiveCDTest_01_07_2022_20_26_44.png)

![VirtualBox_Live CD Test_01_07_2022_20_15_47.png](https://storage.deepin.org/thread/202207012015595089_VirtualBox_LiveCDTest_01_07_2022_20_15_47.png)
![VirtualBox_Live CD Test_01_07_2022_20_17_13.png](https://storage.deepin.org/thread/202207012017254728_VirtualBox_LiveCDTest_01_07_2022_20_17_13.png)
![VirtualBox_Live CD Test_01_07_2022_20_18_48.png](https://storage.deepin.org/thread/202207012018581211_VirtualBox_LiveCDTest_01_07_2022_20_18_48.png)
#### New Kernel（amd64）
基于 Deepin 15/20/23，使用更新版本的内核，项目地址：https://github.com/gfdgd-xi/dclc-kernel 。  

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
<td align="center">2.0.0</td>
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
### 2.0.0
***该版本更新的系列：tiny、mini、full、install、debian-gui、debian-core***

1. 新增 `debian`（全称为 `debian-gui`）、`debian-core` 系列
2. 更新至 6.1.11 内核（arm 为 4.19 内核），`full`、`install` 版升级为 Deepin 20.9
3. 移除有问题的 gitlink 源并更新预装软件
4. 新增 arm 支持（只限 `debian-gui`、`debian-core`）
5. 修复 Full 版无法从 UEFI 启动的问题
6. 更换 squashfs 的压缩参数，使其体积更小
7. 预装星火应用商店终端版

![图片.png](https://storage.deepin.org/thread/202307281450084351_图片.png)

![图片.png](https://storage.deepin.org/thread/202307281456338116_图片.png)

![图片.png](https://storage.deepin.org/thread/202307281534467482_图片.png)

![图片.png](https://storage.deepin.org/thread/202307281504127679_图片.png)

![图片.png](https://storage.deepin.org/thread/202307281500568596_图片.png)

### 1.7.0
#### Install 版
1. 跟进系统版本为 20.8  
2. 更新预装的星火应用商店和 Wine 运行器版本，星火应用商店版本号：4.0.1，Wine 运行器版本号：3.0.0.1-uos  
3. 开始选择性安装 UEngine 安卓环境和 UEngine 运行器（若不想安装，可以通过断网或在体验模式下打开添加自定义脚本进行修改）  
  
![图片.png](https://storage.deepin.org/thread/202212240941481968_图片.png)  
  
![图片.png](https://storage.deepin.org/thread/202212240941227743_图片.png)  
#### Mini 版  
1. 更新 QQ For Linux 至镜像封装时最高版本    
#### Full 15.11 版  
1. 更新 QQ For Linux 至镜像封装时最高版本  
2. 更新了部分 apt 源内更新内容  
#### Full 版  
1. 更新 QQ For Linux 至镜像封装时最高版本  
2. 跟进 Deepin 20.8 更新内容  
  
### 1.6.0
1. 新增 boot repair、Ghost  
2. 有添加用户定制自定义脚本的小工具  
     
![image.png](https://storage.deepin.org/thread/202211091020099456_image.png)  
  
### 1.5.0 
![image.png](https://storage.deepin.org/thread/202210231137072181_image.png)  
  
![image.png](https://storage.deepin.org/thread/202210231147038996_image.png)  
  
![image.png](https://storage.deepin.org/thread/202210231157439386_image.png)  
  
![image.png](https://storage.deepin.org/thread/202210231157552632_image.png)  
  
![image.png](https://storage.deepin.org/thread/202210231158032520_image.png)  
  
# ©2022-Now gfdgd xi
