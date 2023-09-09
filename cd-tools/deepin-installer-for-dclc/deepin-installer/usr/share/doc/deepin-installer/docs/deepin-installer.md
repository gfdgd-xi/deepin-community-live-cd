# 关于
这个可执行文件是安装器的主体程序. 安装器的大部分前端页面都由它来处理.

## 功能
* 处理手动分区
* 处理自动分区
* lupin 自动安装
* 多屏幕支持

## 权限
需要 root 权限才可以执行这个程序, 不然无法正常进行硬盘分区及挂载操作.
可以通过运行 deepin-installer-pkexec 这个脚本来取得 root 权限.

## 选项
* --log LOG_FILE, 将日志备份到 LOG_FILE.
* --conf CONF_FILE, 导入 deepin-installer.conf 的配置, 它会覆盖
 /etc/deepin-installer.conf 中已有的选项.
* --auto-install, 自动安装模式. 这个选项仅用于 lupin 模式. 在这个模式下, 会跳过前面的
 所有页面, 直接转到 InstallProgressFrame, 开始安装.

## 安装流程
为了避免不同版本的分裂，所有版本均采用iso提供deb包，在安装系统时进行所有组件的安装。社区版会提供一个配置好的系统，deb包只提供语言相关的。
packages_default.json包含了界面上需要的组件
packages_choice.json包含了所有组件对应要安装的包
packages_sort.json包含了组件的排序
