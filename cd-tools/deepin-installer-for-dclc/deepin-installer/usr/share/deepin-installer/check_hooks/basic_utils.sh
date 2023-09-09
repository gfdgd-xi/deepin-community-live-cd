#!/bin/bash

# Absolute path to config file.
# Do not read from/write to this file, call installer_get/installer_set instead.
CONF_FILE=/etc/deepin-installer.conf
LIGHTD_CONF_FILE=/etc/lightdm/lightdm.conf

installer_get() {
    local key="$1"
    [ -z "${CONF_FILE}" ] && exit "CONF_FILE is not defined"
    which deepin-installer-settings 1>/dev/null || \
    exit "deepin-installer-settings not found!"
    deepin-installer-settings get "${CONF_FILE}" "${key}"
}

# Set value in conf file. Section name is ignored.
installer_set() {
    local key="$1"
    local value="$2"
    [ -z "${CONF_FILE}" ] && exit "CONF_FILE is not defined"
    which deepin-installer-settings 1>/dev/null || \
    exit "deepin-installer-settings not found!"
    deepin-installer-settings set "${CONF_FILE}" "${key}" "${value}"
}

SI_USERNAME=$(installer_get "system_info_si_user")
SI_PASSWORD=$(installer_get "system_info_si_password")

setNetworkBoot() {
    NETWORK_EFI=$(efibootmgr |grep -i network |awk -F'*' '{print $1}' |sed 's#Boot##')
    efibootmgr -n ${NETWORK_EFI}
}

# 使用sudo权限执行审核模式的过程的函数，该函数可以将脚本执行日志写入到安装器日志中
exec_check() {
    local cmd=$@
    bash /deepin-installer/command.sh $cmd
}

# 判断是否存在桌面
is_desktopexist() {
    HSASTARTDDE=$(dpkg -l | grep dde-desktop)
    if [ -z "${HSASTARTDDE}" ]; then
        return 1
    else
        return 0
    fi
}

# 创建日志文件
addfile_checkmode_log() {
    touch /var/tmp/deepin-installer-checkmode.log
    chmod 777 /var/tmp/deepin-installer-checkmode.log
}

# 删除日志文件
deletefile_checkmode_log() {
    rm -rf /var/tmp/deepin-installer-checkmode.log
}

