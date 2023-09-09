#!/bin/bash

# SI = System Integrity

. "/deepin-installer/basic_utils.sh"

# 创建审核模式日志文件
addfile_checkmode_log

exec_check "/deepin-installer/before_check/"
# wait for lightdm
sleep 5
