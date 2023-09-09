#!/bin/bash
#
# Copyright (C) 2017 ~ 2018 Deepin Technology Co., Ltd.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

# Entry point for hook scripts.
# This script setups variables and function used in hook script.
# Also handles chroot environment.

get_oem_path() {
    local fileList=`find / -path "*/oem/*.job"`
    local fileName
    for name in $fileList
    do
        fileName=$name
        break
    done

    local subString="oem"
    fileName=${fileName%${subString}*}
    fileName=$fileName$subString

    echo $fileName
}

# Check arguments
if [ $# -lt 1 ]; then
  error "Usage: $0 hook-file"
fi

HOOKS_DIR=/tmp/installer
if [ ! -d ${HOOKS_DIR} ];then
    HOOKS_DIR=/usr/share/deepin-installer/hooks
fi

# Folder path of hooks.
## 优化before_install目录脚本执行时，/tmp/installer目录下没有basic_utils.sh文件，另外导致before_install脚本中无法使用定制的basic_utils.sh
if [ -f "$HOOKS_DIR/basic_utils.sh" ];then
    . $HOOKS_DIR/basic_utils.sh
else
    . /usr/share/deepin-installer/hooks/basic_utils.sh
fi

# Absolute path of hook_manager.sh in chroot env.
# This path is defined in service/backend/hooks_pack.cpp.
if [ -f "$HOOKS_DIR/hook_manager.sh" ];then
    _SELF="$HOOKS_DIR/hook_manager.sh"
else
    _SELF="/usr/share/deepin-installer/hooks/hook_manager.sh"
fi

_HOOK_FILE=$1
_IN_CHROOT=$2

# Defines absolute path to oem folder.
# /tmp/oem is reserved for debug.
if [ -d /tmp/oem ]; then
  # Debug mode
  OEM_DIR=/tmp/oem
elif [ -d /media/cdrom/oem ]; then
  # chroot mode
  OEM_DIR=/media/cdrom/oem
elif [ -d /lib/live/mount/medium/oem ]; then
  # chroot mode
  OEM_DIR=/lib/live/mount/medium/oem
elif [ -d /media/apt/oem ]; then
  # chroot mode
  # FIXME: maybe apt will change mount point
  # /media/cdrom => /media/apt
  # hook script invalid
  OEM_DIR=/media/apt/oem
elif [ -d /usr/lib/live/mount/medium/oem ]; then
  # chroot mode
  OEM_DIR=/usr/lib/live/mount/medium/oem
fi

# Mark $OEM_DIR as readonly constant.
readonly OEM_DIR

start_time=$(date +%s)

# Run hook file
case ${_HOOK_FILE} in
  */in_chroot/*)
    if [ "x${_IN_CHROOT}" = "xtrue" ]; then
      if [ ! -f "${CONF_FILE}" ]; then
        error "Config file ${CONF_FILE} does not exists."
      fi
      . "${_HOOK_FILE}"
      end_time=$(date +%s)
      cost_time=$[ $end_time-$start_time ]
      echo "run ${_HOOK_FILE} time is $(($cost_time/60))m $(($cost_time%60))s"
      exit $?
    else
      # Switch to chroot env.
      chroot /target "${_SELF}" "${_HOOK_FILE}" 'true'
    fi
    ;;
  *)
    # Run normal hooks.
    if [ ! -f "${CONF_FILE}" ]; then
      error "Config file ${CONF_FILE} does not exists."
    fi
    . "${_HOOK_FILE}"
    end_time=$(date +%s)
    cost_time=$[ $end_time-$start_time ]
    echo "run ${_HOOK_FILE} time is $(($cost_time/60))m $(($cost_time%60))s"
    exit $?
    ;;
esac
