#!/bin/bash

. ./basic_utils.sh

DI_USER_EXPERIENCE=$(installer_get "DI_USER_EXPERIENCE")

# if not use experience then return
if [ x${DI_USER_EXPERIENCE} == "xtrue" ]; then
   DI_USER_USE_LICENSE=$(installer_get "DI_USER_USE_LICENSE")
   DI_FULLDISK_MODE=$(installer_get "DI_FULLDISK_MODE")
   partition_do_auto_part=$(installer_get "partition_do_auto_part")
   DI_AUTO_MOUNT=$(installer_get "DI_AUTO_MOUNT")
   DI_INSTALL_STARTTIME=$(installer_get "DI_INSTALL_STARTTIME")
   DI_INSTALL_ENDTIME=$(installer_get "DI_INSTALL_ENDTIME")
   DI_INSTALL_SUCCESSED=$(installer_get "DI_INSTALL_SUCCESSED")
   DI_CRYPT_PASSWD=$(installer_get "DI_CRYPT_PASSWD")
   DI_LOCALE=$(installer_get "DI_LOCALE")
   DI_TIMEZONE=$(installer_get "DI_TIMEZONE")
   DI_PASSWDLEVEL=$(installer_get "DI_PASSWDLEVEL")

   #采集是否同意体验计划
   deepin-installer-settings set "/etc/deepin/deepin-user-experience" "ExperiencePlan" "ExperienceState" ${DI_USER_EXPERIENCE}

   #采集是否同意许可协议
   deepin-installer-settings set "/etc/deepin/deepin-user-experience" "ExperiencePlan" "LicenseState" ${DI_USER_USE_LICENSE}

   #采集安装方式
   if [ x${partition_do_auto_part} == "xtrue" ]; then
       installer_record_set "ExperiencePlan" "InstallType" "AutoInstall"
   else
       if [ x${DI_FULLDISK_MODE} == "xtrue" ]; then
           installer_record_set "ExperiencePlan" "InstallType" "FullDiskPartition"
       else
           installer_record_set "ExperiencePlan" "InstallType" "AdvancedPartition"
       fi
   fi

   #采集是否使用自动挂载
   if [ x${DI_AUTO_MOUNT} != "x" ]; then
       installer_record_set "ExperiencePlan" "AutoMount" ${DI_AUTO_MOUNT}
   else
       installer_record_set "ExperiencePlan" "AutoMount" "false"
   fi

   #采集安装时长
   duration=`echo $(($(date +%s -d "${DI_INSTALL_ENDTIME}") - $(date +%s -d "${DI_INSTALL_STARTTIME}"))) | awk '{t=split("60 s 60 m 24 h",a);for(n=1;n<t;n+=2){s=$1%a[n]a[n+1]s;$1=int($1/a[n])} print s}'`
   duration=`echo ${duration/h/:}`
   duration=`echo ${duration/m/:}`
   duration=`echo ${duration%s}`
   installer_record_set "ExperiencePlan" "InstallDuration" ${duration}

   #采集是否安装成功
   installer_record_set "ExperiencePlan" "InstallSuccess" true

   #采集是否使用全盘加密
   if [ x${DI_CRYPT_PASSWD} != "x" ]; then
       installer_record_set "ExperiencePlan" "FullDiskEncrypt" "true"
   else
       installer_record_set "ExperiencePlan" "FullDiskEncrypt" "false"
   fi

   #采集设置的系统语言
   installer_record_set "ExperiencePlan" "LanguageSelected" ${DI_LOCALE}

   #采集设置的系统时区
   installer_record_set "ExperiencePlan" "TimeZoneSelected" ${DI_TIMEZONE}

   #采集是否使用recovery分区
   IS_HASRECOVERY=`lsblk | grep "/recovery" | awk '{print $7}'`
   if [ x${IS_HASRECOVERY} != "x" ];then
       installer_record_set "ExperiencePlan" "UseRecovery" "true"
   else
       installer_record_set "ExperiencePlan" "UseRecovery" "false"
   fi

   #采集设置的密码强度信息
   installer_record_set "ExperiencePlan" "PasswordStrength" ${DI_PASSWDLEVEL}

   sync
else
   rm /etc/deepin/deepin-user-experience
fi

return 0
