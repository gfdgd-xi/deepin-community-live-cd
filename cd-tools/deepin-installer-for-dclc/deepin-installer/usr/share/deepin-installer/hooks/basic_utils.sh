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

# This module defines basic utilities used in almost all scripts.

# Set environment
export LANG=C LC_ALL=C
export DEBIAN_FRONTEND="noninteractive"
export APT_OPTIONS='-y -o Dpkg::Options::="--force-confdef" \
  -o Dpkg::Options::="--force-confold" --force-yes --no-install-recommends \
  --allow-unauthenticated'

# Absolute path to config file.
# Do not read from/write to this file, call installer_get/installer_set instead.
CONF_FILE=/etc/deepin-installer.conf
EXPERIENCE_FILE=/etc/deepin/deepin-user-experience

# Print error message and exit
error() {
  local msg="$@"
  echo " "
  echo "!! Error: ${msg}" >&2
  echo " "
  exit 1
}

warn() {
  local msg="$@"
  echo "Warn: ${msg}" >&2
}

warn_exit() {
  local msg="$@"
  echo "Warn: ${msg}" >&2
  exit 0
}

# standard message
msg() {
  local msg="$@"
  echo "Info: ${msg}"
}

debug() {
  local msg="$@"
  echo "Debug: ${msg}"
}

# Get value in conf file. Section name is ignored.
# NOTE(xushaohua): Global variant or environment $CONF_FILE must not be empty.
installer_get() {
  local key="$1"
  [ -z "${CONF_FILE}" ] && exit "CONF_FILE is not defined"
  which deepin-installer-settings 1>/dev/null || \
    exit "deepin-installer-settings not found!"
  deepin-installer-settings get "${CONF_FILE}" "${key}"
}

installer_record_set(){
   #chroot /target
   local recordsession="$1"
   local recordkey="$2"
   local recordvalue="$3"
   [ -z "${EXPERIENCE_FILE}" ] && exit "EXPERIENCE_FILE is not defined"
   which deepin-installer-settings 1>/dev/null || \
     exit "deepin-installer-settings not found!"
   deepin-installer-settings set "${EXPERIENCE_FILE}" "${recordsession}" "${recordkey}" "${recordvalue}"
}

# Set value in conf file. Section name is ignored.
installer_set() {
  local key="$1"
  local value="$2"
  local workspace=$3
  local CONF_F=$workspace/${CONF_FILE}

  [ -z "${CONF_F}" ] && exit "$CONF_F is not defined"
  which deepin-installer-settings 1>/dev/null || \
    exit "deepin-installer-settings not found!"
  deepin-installer-settings set "${CONF_F}" "${key}" "${value}"
}

update_local() {
    local DI_LOCALE=$(installer_get "DI_LOCALE")
    DI_LOCALE=${DI_LOCALE:-en_US}

    export LANGUAGE=${DI_LOCALE}
    export LANG=${DI_LOCALE}.UTF-8
    export LC_ALL=
}

# update grub config by locale
update_grub_local() {
    update_local
    [ -x /usr/sbin/update-grub ] && /usr/sbin/update-grub
}

# Check whether current platform is loongson or not.
is_loongson() {
  case $(uname -m) in
    loongson | mips* | loongarch64)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

is_loongarch() {
  case $(uname -m) in
    loongarch64)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}


# Check whether current platform is sw or not.
is_sw() {
  case $(uname -m) in
    sw*)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

# Check whether current platform is x86/x86_64 or not.
is_x86() {
  case $(uname -m) in
    i386 | i686 | amd64 | x86 | x86_64)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

# Check whether current platform is arm64 or not.
is_arm64() {
  case $(uname -m) in
    arm64 | aarch64)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

# Check whether graphics card is integrated or not.
is_loongson_integrated_graphics() {
    local ret=$(lshw -c video | grep "driver=loongson-drm")
    if [ ! -z "${ret}" ]; then
        return 0
    else
        return 1
    fi
}

install_package() {
#  DEBIAN_FRONTEND="noninteractive" apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --no-install-recommends --allow-unauthenticated install $@
  for i in $@;
  do
    DEBIAN_FRONTEND="noninteractive" apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" --no-install-recommends --allow-unauthenticated install $i
    if [ $? -eq 0 ]; then
      echo "succeed"
    else
      echo "Install Failed : $i"
    fi
  done
}

setup_lightdm_auto_login() {
  if [ x$(installer_get "lightdm_enable_auto_login") != "xtrue" ]; then
    return 0
  fi

  local USERNAME
  USERNAME=$(installer_get "DI_USERNAME")
  [ -f /etc/lightdm/lightdm.conf ] || warn_exit "lightdm.conf not found!"
  deepin-installer-simpleini set /etc/lightdm/lightdm.conf \
    "Seat:*" "autologin-user" "${USERNAME}"
}

encryption_file() {
    local file=$1
    cat $file | base64 > $file.tmp
    mv $file.tmp $file && chmod 600 $file
}

decryption_file() {
    local file=$1
    cat $file | base64 -d > $file.tmp
    mv $file.tmp $file  && chmod 600 $file
}

select_efi_part() {
    local root_path=`installer_get DI_ROOT_DISK`
    # 获取用户创建的efi
    local efi_dev_path=`installer_get DI_BOOTLOADER`
    # 获取系统盘下的efi
    [ -n "$efi_dev_path" ] || efi_dev_path=`fdisk -l $root_path -o Device,Type | grep -E 'EFI' | awk '{print $1}'`
    # 获取其他盘下的efi
    [ -n "$efi_dev_path" ] || efi_dev_path=`fdisk -l -o Device,Type | grep -E 'EFI' | awk '{print $1}'`
    [ -n "$efi_dev_path" ] && installer_set DI_BOOTLOADER $efi_dev_path
}

add_start_option() {
    local arch_info=$@
    local bootloader_id=$(installer_get "system_startup_option")

    ## 基础启动项,默认UOS
    grub-install $arch_info --efi-directory=/boot/efi --bootloader-id="${bootloader_id}" --recheck \
        || error "grub-install failed with $arch_info" "${bootloader_id}"

    # Copy signed grub efi file.
    is_community || [ -d /boot/efi/EFI/ubuntu ] || mkdir -p /boot/efi/EFI/ubuntu
    is_community || cp -vf /boot/efi/EFI/${bootloader_id}/grub* /boot/efi/EFI/ubuntu/

    [ -d /boot/efi/EFI/boot ] || mkdir -p /boot/efi/EFI/boot
    cp -vf /boot/efi/EFI/${bootloader_id}/grub* /boot/efi/EFI/boot/

    # 32bit机型默认的efi引导文件
    fallback_efi=/boot/efi/EFI/boot/bootia32.efi
    fallback_efi_bak="${fallback_efi}-$(date +%s).bak"
    [ -f "${fallback_efi}" ] && cp "${fallback_efi}" "${fallback_efi_bak}"
    # Override fallback efi with shim.
    cp -vf /boot/efi/EFI/${bootloader_id}/shim*.efi "${fallback_efi}"

    # x86的64bit机型默认的efi引导文件
    if is_x86; then
        fallback_efi=/boot/efi/EFI/boot/bootx64.efi
        fallback_efi_bak="${fallback_efi}-$(date +%s).bak"
        [ -f "${fallback_efi}" ] && cp "${fallback_efi}" "${fallback_efi_bak}"
        # Override fallback efi with shim.
        cp -vf /boot/efi/EFI/${bootloader_id}/shim*.efi "${fallback_efi}"
    fi

    # arm64的64bit机型默认的efi引导文件
    if is_arm64; then
        fallback_efi=/boot/efi/EFI/boot/bootaa64.efi
        fallback_efi_bak="${fallback_efi}-$(date +%s).bak"
        [ -f "${fallback_efi}" ] && cp "${fallback_efi}" "${fallback_efi_bak}"
        # Override fallback efi with shim.
        if ls /boot/efi/EFI/${bootloader_id}/shim* 1>/dev/null 2>&1; then
            cp -vf /boot/efi/EFI/${bootloader_id}/shim*.efi "${fallback_efi}"
        else
            cp -vf /boot/efi/EFI/${bootloader_id}/grubaa64.efi "${fallback_efi}"
        fi
    fi
}

fix_boot_order(){
  command -v efibootmgr >/dev/null 2>&1 || \
    warn "Require efibootmgr installed but not found. Skip"
  return

  local bootinfo=$(efibootmgr)
  echo "bootinfo: ${bootinfo}"
  IFS=$'\n'
  for line in $bootinfo;do
    case $line in
      Boot[0-9A-F][0-9A-F][0-9A-F][0-9A-F]\*\ "${BOOTLOADER_ID}")
        line="${line%%\**}"
        default_bootid="${line##Boot}"
      ;;
    esac
  done

  [ -z ${default_bootid} ] && warn_exit "No ${BOOTLOADER_ID} found, exit..."

  declare -a orderids
  for line in $bootinfo;do
    case $line in
      Boot[0-9A-F][0-9A-F][0-9A-F][0-9A-F]\*\ "${BOOTLOADER_ID}")
        ;;

      Boot[0-9A-F][0-9A-F][0-9A-F][0-9A-F]\*\ ?*)
        line="${line%%\**}"
        orderids[${#orderids[@]}]="${line##Boot}"
        ;;
    esac
  done

  local cmdargs=${default_bootid}
  for arg in ${orderids[@]}; do
    cmdargs=${cmdargs}","${arg}
  done
  efibootmgr -o ${cmdargs}
}

init_backup() {
    echo "init_backup"
}

init_checkmode() {
    echo "init_checkmode"
}

init_firstboot() {
    echo "init_firstboot"
    local CONF_FILE=/etc/lightdm/lightdm.conf
    local TEMP_CONF_FILE=/etc/lightdm/lightdm.conf.real
    if [ -f "${CONF_FILE}" ]; then
        install -v -m644 "${CONF_FILE}" "${TEMP_CONF_FILE}"
    fi

    cat > "${CONF_FILE}" <<EOF
[Seat:*]
display-setup-script=/usr/bin/deepin-installer-bases
greeter-session=lightdm-gtk-greeter
greeter-setup-script=bash /usr/bin/deepin-installer-core /usr/share/deepin-installer-exec/deepin-installer-first-boot
EOF
}

is_service() {
    local type=$(cat /etc/deepin-version | grep Type=)
    type="${type##Type=}"
    if [ "x$type" = "xServer" ]; then
        return 0
    else
        return 1
    fi
}

is_community() {
    local type=$(cat /etc/deepin-version | grep Type=)
    type="${type##Type=}"
    if [ "x$type" = "xDesktop" ]; then
        return 0
    else
        return 1
    fi
}

is_device() {
    local type=$(cat /etc/deepin-version | grep Type=)
    type="${type##Type=}"
    if [ "x$type" = "xDevice" ]; then
        return 0
    else
        return 1
    fi
}

system_name() {
    local name=$(cat /etc/os-version | grep SystemName=)
    name="${name##SystemName=}"
    echo "$name"
}

create_primary_part() {
    local DEV=$1
    local PART_TYPE=$2
    local PART_SIZE=$3

    fdisk $DEV << EOF
n
$PART_TYPE


+${PART_SIZE}M
w
EOF
}

create_logical_part() {
    local DEV=$1
    local PART_SIZE=$2

    fdisk $DEV << EOF
n
l

+${PART_SIZE}M
w
EOF
}

setup_part() {
    local DEV=$1
    local PART_TYPE=$2
    local PART_SIZE=$3
    if [ "x$PART_TYPE" = "xlogical" ]; then
        create_logical_part $DEV $PART_SIZE
    else
        create_primary_part $@
    fi
}

chech_use_crypt(){
  local DI_CRYPT_PASSWD=$(installer_get DI_CRYPT_PASSWD)
  if [ -n "$DI_CRYPT_PASSWD" ]; then
    installer_set DI_CRYPT_PASSWD "NULL"
  fi

  local DI_NEW_CRYPT_PASSWD=$(installer_get DI_NEW_CRYPT_PASSWD)
  if [ -n "$DI_NEW_CRYPT_PASSWD" ]; then
    installer_set DI_NEW_CRYPT_PASSWD "NULL"
  fi
}

update_disk_cryption_passwd(){
    local old_passwd=$(installer_get DI_CRYPT_PASSWD)
    local new_passwd=$(installer_get DI_NEW_CRYPT_PASSWD)
    local PART_DEVICE=$(installer_get "DI_FULLDISK_MULTIDISK_DEVICE")
    local part_device_array=(${PART_DEVICE//;/ })

    for(( i=0;i<${#part_device_array[@]};i++ )) do
        local device=${part_device_array[i]}
        local crypt_part="/dev/$(lsblk -lf $device -o NAME,FSTYPE | grep -E "crypto_LUKS" | awk '{print $1}')"
        if [ -n "$new_passwd" ] && [ -n "$old_passwd" ]; then
            cryptsetup luksAddKey $crypt_part << EOF
$old_passwd
$new_passwd
$new_passwd
EOF
            echo -n "$old_passwd" | cryptsetup luksRemoveKey $crypt_part
        fi
    done

    chech_use_crypt  # 清空配置文件中的密码
}

save_old_user_data() {
    local WORK_DIR="/home"
    local USERNAME=$(installer_get DI_USERNAME)
    local DIR_LISTS=$(ls $WORK_DIR | grep -v "^${USERNAME}$" \
        | xargs -I {} echo $WORK_DIR/{} | xargs echo)

    local DEBUG_FLAG=$(installer_get system_debug)
    local CMD_ARGS="-a --progress --remove-source-files"

    if [ "x$DEBUG_FLAG" != "xtrue"  ]; then
        CMD_ARGS="-a --remove-source-files"
    fi

    echo "DIR_LISTS=$DIR_LISTS"
    if [ -n "$DIR_LISTS" ]; then
        rsync $CMD_ARGS $DIR_LISTS $WORK_DIR/.old_user_data
        chown root:root $WORK_DIR/.old_user_data -R
        rm -fr $DIR_LISTS
    fi
}

skip_disk_crypt() {
    local workspace=$1
    local DI_CRYPT_PASSWD=$(installer_get "DI_CRYPT_PASSWD")
    local DI_ROOT_DISK=$(installer_get "DI_ROOT_DISK")
    local boot_uuid=$(lsblk -f $DI_ROOT_DISK -o UUID,MOUNTPOINT | grep -E "/target/boot$" | awk '{print $1}')

    local cryp_conf_file=$workspace/etc/crypttab
    local PART_DEVICE=$(installer_get "DI_FULLDISK_MULTIDISK_DEVICE")
    local part_device_array=(${PART_DEVICE//;/ })

    for(( i=0;i<${#part_device_array[@]};i++ )) do
        local device=${part_device_array[i]}
        # 获取全盘加密的分区设备文件
        local crypt_path="/dev/$(lsblk -lf $device -o NAME,FSTYPE | grep -E "crypto_LUKS" | awk '{print $1}')"
        # 获取全盘加密的分区uuid
        local crypt_uuid=$(lsblk -f $device -o UUID,FSTYPE | grep -E "crypto_LUKS" | awk '{print $1}')
        echo "disk cyrpt info: device=$device  boot_uuid=$boot_uuid  crypt_path=$crypt_path  crypt_uuid=$crypt_uuid"

        if [ -n "$crypt_uuid" ]; then
            local luks_name=luks_crypt${i}
            local key_file=$workspace/etc/deepin/crypt_keyfile_${i}.key

            # 使用随机数创建的密钥文件
            dd if=/dev/urandom of=$key_file bs=1024 count=4
            chmod 0400 $key_file
            # 添加密钥文件到加密设备中
            echo -n "$DI_CRYPT_PASSWD" | cryptsetup -v luksAddKey $crypt_path $key_file
            # 备份原始的加密配置文件，方便后续清理
            [ -f ${cryp_conf_file}.real ] || mv $cryp_conf_file ${cryp_conf_file}.real
            # 生成keyfile配置
            echo "$luks_name UUID=$crypt_uuid /etc/deepin/crypt_keyfile_${i}.key luks,initramfs" >> $cryp_conf_file
        fi
    done
    cat $cryp_conf_file

    if [ -n "$DI_CRYPT_PASSWD" ]; then
        local crypt_initramfs=$workspace/etc/cryptsetup-initramfs/conf-hook
        [ -f ${crypt_initramfs}.real ] || mv $crypt_initramfs ${crypt_initramfs}.real
        # 配置自定义keyfile的位置
        echo "KEYFILE_PATTERN=/etc/deepin/crypt_keyfile_*.key" >> $crypt_initramfs
        cat $crypt_initramfs
        chroot $workspace /usr/sbin/update-initramfs -u
    fi
}

run() {
    local file=$1
    echo "run script: $file"
    bash $file
}

run_job() {
    local in=$1
    if [ -d "$in" ];then
        echo "run dir: $in"
        JOBS=$(ls $in/*.job)
        for job in $JOBS; do
            local JOB_SRP=$job
            run $JOB_SRP
        done
    fi

    if [ -f "$in" ];then
        run $in
    fi
}

first_boot_oem () {
    local oem_deb_dir="/usr/share/deepin-installer/first_boot_deb"
    local oem_hooks_dir="/usr/share/deepin-installer/hooks/first_boot"
    echo "install first boot oem deb start..."
    if [[ $(ls "${oem_deb_dir}"/*.deb 2>/dev/null) ]]; then
        ls "${oem_deb_dir}"
        DEBIAN_FRONTEND="noninteractive"
        apt-get -y --allow-downgrades install -o Dpkg::Options::="--force-confnew" "${oem_deb_dir}/"*.deb || warn "Failed to install oem deb packages"
    fi
    echo "first boot oem hooks start..."
    if [[ $(ls "${oem_hooks_dir}"/*.job 2>/dev/null) ]]; then
        ls "${oem_hooks_dir}"
        run_job "$oem_hooks_dir"
    fi
    rm -vfr $oem_deb_dir $oem_hooks_dir
    echo "first boot oem end!"
}

