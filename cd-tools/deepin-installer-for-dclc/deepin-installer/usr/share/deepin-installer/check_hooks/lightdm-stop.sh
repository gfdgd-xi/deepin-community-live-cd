#!/bin/bash

# SI = System Integrity

. "/deepin-installer/basic_utils.sh"

exec_check "/deepin-installer/after_check/"
exec_check "/deepin-installer/check_stop.sh"    # 清理审核模式，使用exec_check可以将日志写入到安装器日志中


