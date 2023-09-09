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

# Automatically create disk partitions.
# Partition policy is defined in settings.ini.
declare -i  DEVICE_SIZE AVL_SIZE PART_NUM=0 LVM_NUM=0 LAST_END=1 LOGICAL_SECTORS_PER_MB
declare CRYPT_INFO DEVICE PART_POLICY PART_LABEL MP_LIST VG_NAME="vg0" PART_TYPE="primary" \
        LARGE="false" EFI="false" LVM="false"

# Check device capacity of $DEVICE.
check_device_size(){
  local index=$1
  echo "index={${index}}"
  local minimum_disk_size=$(installer_get disk_minimum_space_required)
  local large_disk_threshold=$(installer_get partition_full_disk_large_disk_threshold)
  DEVICE_SIZE=$(($(blockdev --getsize64 "$DEVICE") / 1024**2))

  if ((DEVICE_SIZE < minimum_disk_size * 1024 && index == 0)); then
    error "At least ${minimum_disk_size}Gib is required to install system!"
  elif ((DEVICE_SIZE > large_disk_threshold * 1024)); then
    declare -g LARGE=true
  fi
}

# Check boot mode is UEFI or not.
check_efi_mode(){
  is_sw && declare -g EFI=true
  [ -d "/sys/firmware/efi" ] && declare -g EFI=true
  local force_efi=$(installer_get force_efi_mode)
  [ x"$force_efi" = "xtrue" ] && declare -g EFI=true
}

# Flush kernel message.
flush_message(){
  udevadm settle --timeout=5
}

# Format partition at $1 with filesystem $2.
format_part(){
  local part_path="$1" part_fs="$2" part_label="$3"
  local part_fs_="$part_fs"
  if [ "$part_fs_" = "recovery" ]; then
     part_fs_=ext4
  fi

  yes |\
  case "$part_fs_" in
    vfat)
      mkfs.vfat -F32 -n "$part_label" "$part_path";;
    fat32)
      mkfs.vfat -F32 -n "$part_label" "$part_path";;
    efi)
      mkfs.vfat -F32 -n "$part_label" "$part_path";;
    fat16)
      mkfs.vfat -F16 -n "$part_label" "$part_path";;
    ntfs)
      mkfs.ntfs --fast -L "$part_label" "$part_path";;
    linux-swap)
      mkswap "$part_path";;
    swap)
      mkswap "$part_path";;
    ext4)
      if is_loongson || is_sw; then
        mkfs.ext4 -O ^64bit -F -L "$part_label" "$part_path"
      else
        mkfs.ext4 -L "$part_label" "$part_path"
      fi
    ;;
    xfs)
      mkfs.xfs -f -L "$part_label" "$part_path"
    ;;
    *)
      mkfs -t "$part_fs" -L "$part_label" "$part_path";;
  esac || error "Failed to create $part_fs filesystem on $part_path!"
}

get_max_capacity_device(){
  local name size max_device max_size=0
  while read name size; do
    if ((size >= max_size)); then
      max_size="$size"
      max_device="/dev/$name"
    fi
  done < <(lsblk -ndb -o NAME,SIZE)
  DEVICE="$max_device"
}

get_logical_sectors_per_MB(){
    local device=$1
    declare -i logical_sector_size
    logical_sector_size=$(fdisk -l ${device} | grep "^Units" | awk -F "=" '{print $2}' | awk '{print $1}')
    [ ! $logical_sector_size -gt 0 ] && error "Failed to get logical sector size on $device!"

    LOGICAL_SECTORS_PER_MB=$((1024 * 1024 / logical_sector_size))
    [ ! $LOGICAL_SECTORS_PER_MB -gt 0 ] && error "Failed to calc logical sector counts per MB on $device!"
}

align_partition_start(){
    declare -i start=$1

    # 向上取整对齐，对齐条件优先级：不小于调整之前的值 >= 为LOGICAL_SECTORS_PER_MB整数倍
    start=$(((start + LOGICAL_SECTORS_PER_MB - 1) / LOGICAL_SECTORS_PER_MB * LOGICAL_SECTORS_PER_MB))

    echo $start
}

align_partition_end(){
    declare -i end=$1

    # 向下取整对齐，对齐条件优先级：不大于调整之前的值 >= 不小于0 >= 比LOGICAL_SECTORS_PER_MB整数倍少一个扇区
    end=$(((end + 1) / LOGICAL_SECTORS_PER_MB * LOGICAL_SECTORS_PER_MB))

    [ $end -gt 0 ] && end=$((end - 1))

    echo $end
}

# Create new partition table.
new_part_table(){
  if [ "x$EFI" == "xtrue" ] || is_sw ; then
    local part_table="gpt"
  else
    local part_table="msdos"
  fi

  echo "part_table=${part_table}"
  parted -s "$DEVICE" mktable "$part_table" ||\
    error "Failed to create $part_table partition on $DEVICE!"

  echo "new part table: $DEVICE = $part_table"
}

umount_devices(){
  # Umount all swap partitions.
  swapoff -a

  # Umount /target
  [ -d /target ] && umount -R /target
}

get_next_part_start_pos() {
    local dev_info=$1
    # 计算分区信息
    local offset=$(fdisk -l $dev_info | grep  "^$dev_info" | wc -l)
        PART_NUM=$offset
    if [ $offset = '0' ]; then
        offset=$LOGICAL_SECTORS_PER_MB
    else
        local end=$(expr $(fdisk -l $dev_info -o END | sed -n '$p') + 1)
        offset=$end
    fi

    echo $offset
}

get_system_disk_extend_size() {
    local size=$(installer_get "DI_FULLDISK_MULTIDISK_EXTSIZE_0")
    echo $((size * LOGICAL_SECTORS_PER_MB))
}

# Create partition.
create_part() {
  local part="$1"
  local label="$2"
  local dev=$3
  local swap_size part_path part_mp part_fs _part_fs part_start part_end mapper_name

  echo "label:{${label}}"
  [[ "${label}" == "null" ]] && label=""

  let PART_NUM++
  echo "============PART_NUM: $PART_NUM============"

  echo "PART:{${part}},label:{${label}}"

  # Get partition info.
  [[ "$part" =~ ^(.*):(.*):(.*):(.*)$ ]] || error "Bad partition info!"
  part_mp="${BASH_REMATCH[1]}"
  part_fs="${BASH_REMATCH[2]}"
  part_size="${BASH_REMATCH[4]}"
  part_start=$(get_next_part_start_pos $dev)
  # Create extended partition.
  if ((PART_NUM == 2)) && (! ($EFI || $LVM)) && \
    [ "x$part_fs" != "xlvm_type" ] && [ "x$part_fs" != "xcrypto_luks" ]; then
    echo "Create extended partition..."
    part_end=$((part_start + $(get_system_disk_extend_size)))
    part_end=$(align_partition_end $part_end)

    part_start=$(align_partition_start $part_start)

    parted -s "$DEVICE" mkpart extended "${part_start}s" "${part_end}s" ||\
      error "Failed to create extended partition on $DEVICE!"
    #setup_part $dev "extended" $(get_system_disk_extend_size)
    let PART_NUM=5
    echo "============PART_NUM: $PART_NUM============"
    PART_TYPE="logical"
  fi
  if ! $LVM; then
    AVL_SIZE=$((DEVICE_SIZE - 1 - part_start / LOGICAL_SECTORS_PER_MB))
    # gpt格式磁盘需要在尾部预留33个扇区空间存储分区表
    [ "x$EFI" == "xtrue" ] && AVL_SIZE=$((AVL_SIZE - 33 - 1))
  else
    [[ "$(vgs -ovg_free --readonly --units m $VG_NAME)" =~ ([0-9]+) ]] &&\
      AVL_SIZE="${BASH_REMATCH[1]}"
  fi

  echo "Avaiable size: $AVL_SIZE"

  if [[ "$part_size" =~ %$ ]]; then
      part_size=$((AVL_SIZE * ${part_size%\%} / 100))
  elif [ ${part_size} -gt ${AVL_SIZE} ] && [ ${AVL_SIZE} -gt 0 ]; then
      echo "adjuest part_size:${part_size}=>${AVL_SIZE}"
      part_size=${AVL_SIZE}
  fi
  echo "Calculated partition size: $part_size"

  # Create new partition.
  if ! $LVM; then
    case "$part_fs" in
      efi)
        _part_fs=fat32;;
      crypto_luks)
        _part_fs='';;
      lvm_type)
        _part_fs=''
        PART_TYPE="primary"
        [ "x$EFI" != "xtrue" ] && [ $PART_NUM -gt 4 ] && PART_NUM=3
        ;;
      recovery)
        _part_fs=ext4;;
      *)
        printf -v _part_fs '%q' "$part_fs";;
    esac

    # 分区最小对齐
    part_end=$((part_start + part_size * LOGICAL_SECTORS_PER_MB))
    part_end=$(align_partition_end $part_end)

    part_start=$(align_partition_start $part_start)
    [ "x$PART_TYPE" = "xlogical" ] && part_start=$((part_start + LOGICAL_SECTORS_PER_MB))

    echo "part: $part_mp, $part_fs, $part_start, $part_end"
    if parted -s "$DEVICE" mkpart "$PART_TYPE" $_part_fs "${part_start}s" "${part_end}s"; then
    #if setup_part $dev $PART_TYPE $part_size ; then
      if [[ "$DEVICE" =~ [0-9]$ ]]; then
        part_path="${DEVICE}p${PART_NUM}"
      else
        part_path="${DEVICE}${PART_NUM}"
      fi
    else
      error "Failed to create partition $part_mp!"
    fi
  else
    let LVM_NUM++
    part_size=$((part_size - 2))  # LVM需要额外的2Mib空间
    echo "{LVM_NUM:{${LVM_NUM},label:{${label:-LVM_NUM${LVM_NUM}}} vg_name:{${VG_NAME}}"
    lvcreate --wipesignatures y -n"${label:-LVM_NUM${LVM_NUM}}" -L"$part_size" "$VG_NAME" --yes ||\
        error "Failed to create logical volume ${label:-LVM_NUM${LVM_NUM}} on $VG_NAME!"

    part_path="/dev/$VG_NAME/${label:-LVM_NUM${LVM_NUM}}"
  fi

  flush_message

  # Create filesystem.
  case "$part_fs" in
    efi)
      {
        format_part "$part_path" fat32 "$label" &&\
        # Set esp flag.
        parted -s "$DEVICE" set "$PART_NUM" esp on
      } || error "Failed to create ESP($part_path) on $DEVICE!"

      # No need to append EFI partition to mount point list.
      # MP_LIST="${MP_LIST+$MP_LIST;}$part_path=$part_mp"
      installer_set DI_BOOTLOADER "$part_path"
      ;;
    crypto_luks)
      mapper_name="$part_mp"
      part_mp="/dev/mapper/$mapper_name"

      installer_set DI_CRYPT_ROOT "true"

      [[ -n ${CRYPT_INFO} ]] && CRYPT_INFO+=";"
      CRYPT_INFO+="$part_path:$mapper_name"

      local crypt_algorithm=$(installer_get disk_crypt_algorithm)

      msg "cryptsetup ${crypt_algorithm} -v luksFormat "$part_path""

      DI_CRYPT_PASSWD=$(installer_get DI_CRYPT_PASSWD)

      if [ "x$(installer_get "all_password_encryption")" = "xtrue" ]; then
          {
              command-execute-agent "$DI_CRYPT_PASSWD" "echo \"%1\" | cryptsetup ${crypt_algorithm} -v luksFormat \"$part_path\"" &&\
              command-execute-agent "$DI_CRYPT_PASSWD" "echo \"%1\" | cryptsetup open \"$part_path\" \"$mapper_name\""
          } || error "Failed to create luks partition($part_path)!"
      else
          {
              echo "$DI_CRYPT_PASSWD" | cryptsetup ${crypt_algorithm} -v luksFormat "$part_path" &&\
              echo "$DI_CRYPT_PASSWD" | cryptsetup open "$part_path" "$mapper_name"
          } || error "Failed to create luks partition($part_path)!"
      fi

      {
        pvcreate "$part_mp" -ffy &&\
        vgcreate "$VG_NAME" "$part_mp"
      } || error "Failed to create volume group: $VG_NAME!"
      declare -g LVM="true"
      ;;
    lvm_type)
      {
        VG_NAME=$part_mp
        pvcreate "$part_path" -ffy &&\
        vgcreate "$VG_NAME" "$part_path"
      } || error "Failed to create volume group: $VG_NAME!"
      declare -g LVM="true"
      ;;
    *)
      format_part "$part_path" "$part_fs" "$label" ||\
        error "Failed to create $part_fs filesystem on $part_path!"
      [ -n "$part_mp" ] && MP_LIST="${MP_LIST+$MP_LIST;}$part_path=$part_mp"
      ;;
  esac

  flush_message

  # Set boot flag.
  case "$part_mp" in
    /boot)
      # Set boot flag in legacy mode.
      $EFI || parted -s "$DEVICE" set "$PART_NUM" boot on
      ;;
    /)
      installer_set "DI_ROOT_PARTITION" "$part_path"
      # Set boot flag if /boot is not used in legacy mode.
      ($EFI || $LVM || [[ "$PART_POLICY" =~ "/boot:" ]]) ||\
        parted -s "$DEVICE" set "$PART_NUM" boot on
      ;;
  esac || error "Failed to set boot flag on $part_path!"

  flush_message
}

delete_part() {
    local DEVICE=$1
    local NUM=$2
    parted -s $DEVICE rm $NUM
}

delete_lvm() {
    local DEVICE=$1
    local vg_path="/dev/$(pvdisplay -c | grep -i "$DEVICE" | awk -F ":" '{print $2}')"
    local pv_name=$(pvdisplay -c | grep -i "$DEVICE" | awk -F ":" '{print $1}')
    echo "vg_path=$vg_path; pv_name=$pv_name"
    if [ -n "$pv_name" ]; then
        if [ -f "$vg_path" ]; then
            for lv_name in $vg_path/*
            do
                lvremove -f $lv_name
            done
        fi
        vgremove -f $vg_path
        pvremove -f $pv_name
    fi
}

delete_crypt_lvm() {
    local DEVICE=$1
    local luks_crypt=$(lsblk -l $DEVICE | grep luks_crypt)
    if [ -n "$luks_crypt" ]; then
        DEVICE="/dev/mapper/$luks_crypt"
    fi
    delete_lvm $DEVICE
}

get_part_path() {
    local DEVICE=$1
    local LABEL=$2
    local PART_PATH=$(lsblk -lf $DEVICE | grep $LABEL | awk '{print $1}')
    if [ ! -n "$PART_PATH" ]; then
        echo ""
    else
        echo "/dev/$PART_PATH"
    fi
}
get_part_number() {
    local PART_PATH=$1
    echo "${PART_PATH##*[a-zA-Z]}"
}

get_part_fstype() {
    local DEVICE=$1
    local LABEL=$2
    local PART_LABEL=$(lsblk -o FSTYPE,LABEL $DEVICE | grep $LABEL | awk '{print $1}')
    if [ ! -n "$PART_LABEL" ]; then
        echo ""
    else
        echo "$PART_LABEL"
    fi
}

get_part_mountpoint() {
    local LABEL=$1
    if [ "x$LABEL" = "xEFI" ]; then
        echo "/boot/efi"
    elif [ "x$LABEL" = "xBoot" ]; then
        echo "/boot"
    elif [ "x$LABEL" = "xBackup" ];then
        echo "/recovery"
    elif [ "x$LABEL" = "xSWAP" ];then
        echo "swap"
    elif [ "x$LABEL" = "xRoota" ];then
        echo "/"
    elif [ "x$LABEL" = "x_dde_data" ];then
        echo "$(installer_get DI_DATA_MOUNT_POINT)"
    else
        echo ""
    fi
}

proc_empty_str() {
    local str="$1"
    while [[ "${str}" =~ ";;" ]]
    do
        str=$(echo "${str}" | sed 's/;;/;null;/g')
    done
    [[ "${str}" =~ \;$ ]] && str=${str}null
    [[ "${str}" =~ ^\; ]] && str=null${str}
    echo ${str}
}

main(){
  # Based on the following process:
  #  * Umount devices.
  #  * Get boot mode.
  #  * Get partitioning policy.
  #  * Create new partition table.
  #  * Create partitions.
  #  * Notify kernel.

  installer_set DI_UEFI "false"
  umount_devices

  local policy_device="DI_FULLDISK_MULTIDISK_DEVICE"
  local policy_name="DI_FULLDISK_MULTIDISK_POLICY_"
  local policy_name_label="DI_FULLDISK_MULTIDISK_LABEL_"

  local PART_DEVICE=$(installer_get $policy_device)
  local part_device_array=(${PART_DEVICE//;/ })
  declare -i index=0

  for j in "${part_device_array[@]}"; do
     DEVICE="${j}"
     VG_NAME="vg${index}"
     echo "Target device: {$DEVICE} VG_NAME:{${VG_NAME}}"

     DEVICE_SIZE=0
     AVL_SIZE=0
     #PART_NUM=0
     LVM_NUM=0
     LAST_END=1

     LVM="false"
     PART_TYPE="primary"
     LARGE="false"
     EFI="false"
     LVM="false"
     partprobe "$DEVICE"
     if [ "$DEVICE" = auto_max ]; then
        get_max_capacity_device
     fi
     [ -b "$DEVICE" ] || error "Device not found!"

    check_device_size ${index}
    get_logical_sectors_per_MB ${DEVICE}
    check_efi_mode
    echo "Device size: $DEVICE_SIZE"

    PART_POLICY=$(installer_get ${policy_name}${index})
    PART_LABEL=$(installer_get ${policy_name_label}${index})
    echo "POLICY:{${PART_POLICY}}"
    echo "LABEL:{${PART_LABEL}}"

    local part_policy_array=(${PART_POLICY//;/ })
    local part_label_array=$(proc_empty_str ${PART_LABEL})
    part_label_array=(${part_label_array//;/ })

    echo "policy:{${part_policy_array[@]}}"
    echo "label:{${part_label_array[@]}}"
    echo "policy#:${#part_policy_array[@]} label:${#part_label_array[@]}"

    if [ x$(installer_get "multi_system_eanble") = "xtrue" ]; then
      echo "multi_system is true"
      PART_NUM=$(installer_get DI_PART_NUM)
    else
      PART_NUM=0
      delete_lvm "$DEVICE"
      delete_crypt_lvm "$DEVICE"
      new_part_table "$DEVICE"
    fi

    for i in "${!part_policy_array[@]}"; do
        create_part "${part_policy_array[$i]}" "${part_label_array[$i]}" "${DEVICE}"
    done
    index=index+1

  done

  echo "MOUNTPOINTS:{${MP_LIST}}"
  echo "ROOT_DISK:{${part_device_array[0]}}"

  installer_set DI_MOUNTPOINTS "$MP_LIST"

#  # Write boot method.
  if $EFI; then
    installer_set DI_UEFI "true"

    is_sw && installer_set DI_BOOTLOADER "${part_device_array[0]}"
  else
    installer_set DI_BOOTLOADER "${part_device_array[0]}"
  fi

  echo "CRYPT_INFO:{${CRYPT_INFO}}"
  installer_set DI_CRYPT_INFO "${CRYPT_INFO}"
  installer_set DI_ROOT_DISK "${part_device_array[0]}"
  installer_set DI_FULLDISK_MODE "true"
}

part_to_device() {
    local part_path=$1
    echo "$part_path" | sed -r "s/[p]{0,1}[0-9]+$//g"
}

sava_data() {

  local PART_DEVICE=$(installer_get "DI_FULLDISK_MULTIDISK_DEVICE")
  local part_device_array=(${PART_DEVICE//;/ })
  local ROOT_DISK="${part_device_array[0]}"
  local LEN=${#part_device_array[@]}

  for j in "${part_device_array[@]}"; do
    DEVICE="${j}"
    # 获取磁盘分区label
    part_labels=$(lsblk -o LABEL -lnf $DEVICE | grep [a-z/A-Z] | xargs)
    IFS=" "
    local part_labels_arr=(${part_labels})
    for j in "${part_labels_arr[@]}"; do
        local p_label=$j
        local p_path=$(get_part_path $DEVICE $p_label)
        local p_fs=$(get_part_fstype $DEVICE $p_label)
        local p_mountpoint=$(get_part_mountpoint $p_label)
        echo "part_info: $p_label;$p_path;$p_fs;$p_mountpoint"
        if [ "x$p_label" = "xEFI" ] || [ "x$p_label" = "xBoot" ] || [ "x$p_label" = "xBackup" ] \
                || [ "x$p_label" = "xRoota" ] || [ "x$p_label" = "xRootb" ]; then
            format_part "$p_path" "$p_fs" "$p_label" ||\
              error "Failed to create $p_fs filesystem on $p_path!"
        fi

        [ "x$p_label" = "xBoot" ] && installer_set "DI_BOOTLOADER" "$(part_to_device ${p_path})"
        [ "x$p_label" = "xRoota" ] && installer_set "DI_ROOT_PARTITION" "$p_path"

        # 系统和数据盘里都有data分区时，只挂载数据盘里的分区，清理掉系统盘的挂载点
        [ $LEN -eq 2 ] && [ "x$ROOT_DISK" = "x$DEVICE" ] && [ "x$p_label" = "x_dde_data" ] \
            && p_mountpoint=""
        # 系统和数据盘里都全盘安装过系统时，只挂载系统盘里除data分区以外的分区，清理掉数据盘中除data分区以外的分区的挂载点
        [ $LEN -eq 2 ] && [ "x$ROOT_DISK" != "x$DEVICE" ] && [ "x$p_label" != "x_dde_data" ] \
            && p_mountpoint=""

        [ -n "$p_mountpoint" ] && MP_LIST="${MP_LIST+$MP_LIST;}$p_path=$p_mountpoint"
    done
  done

  echo "MOUNTPOINTS:{${MP_LIST}}"
  echo "ROOT_DISK:{${part_device_array[0]}}"

  installer_set DI_MOUNTPOINTS "$MP_LIST"

  check_efi_mode
  if $EFI; then
    installer_set DI_UEFI "true"
  fi

  # 寻找EFI
  local part_path=$(fdisk -l -o Device,Type | grep $ROOT_DISK | grep EFI | awk '{print $1}')
  if [ -n "$part_path" ]; then
    installer_set "DI_BOOTLOADER" $part_path
  fi

  installer_set DI_ROOT_DISK "$ROOT_DISK"
  installer_set DI_FULLDISK_MODE "true"
}

. ./basic_utils.sh

DI_CUSTOM_PARTITION_SCRIPT=$(installer_get DI_CUSTOM_PARTITION_SCRIPT)
SAVE_DATA=$(installer_get DI_SAVE_DATA)
echo "SAVE_DATA=$SAVE_DATA"
if [ -f "$DI_CUSTOM_PARTITION_SCRIPT" ]; then
  echo "Call custom partition script($DI_CUSTOM_PARTITION_SCRIPT)..."
  bash "$DI_CUSTOM_PARTITION_SCRIPT"
elif [ "x$SAVE_DATA" = "xtrue" ]; then
  sava_data
else
  main
fi

