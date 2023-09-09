# Deepin15的兼容环境（也支持Deepin20/23）
## 介绍
这个兼容环境和 ablrun 一样都用到了 bwrap，但是不同之处（目的也并不相同）在于 ablrun 只提供新版的 glibc 以解决 glibc 问题，而此环境（也叫 gx-env）则提供了较为完整的容器，这里用的是 Ubuntu 22.04（一开始是想让 deepin 15.11 能够运行一些比较新的软件）  
但是比较坑的是 bwrap 的权限问题，例如在这个兼容中不能用 sudo（和 pkexec），以及使用起来会比 ablrun 繁琐（恼），以及运行 chrome 内核的应用也有问题（deepin23好像就可以，可能是 bwrap 后续修复了这个问题）  
目前这个东东的完成度还不高，反正能用就行  
***在第一次运行该程序时会提示要输入密码，别点取消啊，不然兼容环境用不了别怪我***  

也提供了预装该兼容环境的系统安装镜像，预装 6.1.11-hwe 内核，如果出现 安装镜像的安装 deb 包按钮按了没用的问题，输入`sudo apt update ; sudo apt upgrade`获取更新包即可  

（更详细的可以看我近一段时间的 B 站动态：https://space.bilibili.com/695814694/dynamic）

![图片.png](https://storage.deepin.org/thread/202306291315217232_图片.png)

![深度截图_20230629075026.png](https://storage.deepin.org/thread/202306291318502848_深度截图_20230629075026.png)

![深度截图_20230629075351.png](https://storage.deepin.org/thread/202306291318448073_深度截图_20230629075351.png)

![深度截图_20230629075707.png](https://storage.deepin.org/thread/202306291318362294_深度截图_20230629075707.png)

![深度截图_20230629082954.png](https://storage.deepin.org/thread/20230629131830479_深度截图_20230629082954.png)

## 常见问题

### 如何在兼容环境安装应用

安装程序后启动器会出现一个“兼容环境设置”的东东，在这里面就可以选择从 星火应用商店 和 deb 安装器安装  

![图片.png](https://storage.deepin.org/thread/202306291326461563_图片.png)  
如果在安装程序后并关闭 deb 安装器/星火应用商店却没有在启动器出现快捷方式，可以点击“刷新启动器图标”按钮重新生成  

### 能用这个运行 UEngine 环境吗（在deepin15.11运行UEngine环境）

不能

### 能用这个运行 Wine 环境吗（在deepin15.11运行Wine环境）

可以
![深度截图_20230629082954.png](https://storage.deepin.org/thread/20230629131830479_深度截图_20230629082954.png)

### 能使用 sudo/pkexec 吗

因为 bwrap 的限制，不行。  
但是你可以在“兼容环境设置”里面的“打开终端（root）”来变相获取 root 权限

### 如何在兼容环境运行 chrome 内核应用？

因为 bwrap 的问题（23似乎修复了），需要在 “兼容环境设置”中勾选 --no-sandbox 选项并保存，并点击“刷新图标按钮”  
注：部分程序可能在勾选该选项后会异常或无法运行，如无必要不建议开启  

### 能在非 X86 架构上使用吗

如果有非X86架构的gx-env-runtime包就可以  

### 能命令调用吗

可以，使用 `gx-env-run` 命令即可

### 为什么提供的 Deepin15.11 安装镜像的安装 deb 包按钮按了没用

因为打包打的太急，出了些问题，输入`sudo apt update ; sudo apt upgrade`获取更新包即可

### 支持声音和输入法吗

支持（前提不是以 root 权限运行），但例如网易云音乐等程序还是不行

## 下载链接

Gitee：https://gitee.com/gfdgd-xi/deepin15-ubuntuenv
Github：https://github.com/gfdgd-xi/deepin15-ubuntuenv
123盘：https://www.123pan.com/s/pDSKVv-UxaWv.html

# ©2023~Now gfdgd xi