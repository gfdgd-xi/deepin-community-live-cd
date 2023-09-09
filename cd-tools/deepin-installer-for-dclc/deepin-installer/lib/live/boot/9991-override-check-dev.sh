#!/bin/sh

is_supported_fs ()
{
    fstype="${1}"

    # Validate input first
    if [ -z "${fstype}" ]
    then
        return 1
    fi

    # get_fstype might report "unknown" or "swap", ignore it as no such kernel module exists
    if [ "${fstype}" = "unknown" ] || [ "${fstype}" = "swap" ]
    then
        return 1
    fi

    if [ "${fstype}" = "ntfs" ]
    then
        # FIXME: deepin installer should handle ntfs fstype
        return 0 
    fi

    # Try to look if it is already supported by the kernel
    if grep -q ${fstype} /proc/filesystems
    then
        return 0
    else
        # Then try to add support for it the gentle way using the initramfs capabilities
        modprobe -q -b ${fstype}
        if grep -q ${fstype} /proc/filesystems
        then
            return 0
            # Then try the hard way if /root is already reachable
        else
            kmodule="/root/lib/modules/`uname -r`/${fstype}/${fstype}.ko"
            if [ -e "${kmodule}" ]
            then
                insmod "${kmodule}"
                if grep -q ${fstype} /proc/filesystems
                then
                    return 0
                fi
            fi
        fi
    fi

    return 1
}

check_dev ()
{
    local force fix
    sysdev="${1}"
    devname="${2}"
    skip_uuid_check="${3}"

    if [ -z "${devname}" ]
    then
        devname=$(sys2dev "${sysdev}")
    fi

    if [ -d "${devname}" ]
    then
        mount -o bind "${devname}" $mountpoint || continue

        if is_live_path $mountpoint
        then
            echo $mountpoint
            return 0
        else
            umount $mountpoint
        fi
    fi

    IFS=","
    for device in ${devname}
    do
        case "$device" in
            *mapper*)
                # Adding lvm support
                if [ -x /scripts/local-top/lvm2 ]
                then
                    ROOT="$device" resume="" /scripts/local-top/lvm2 >>/boot.log
                fi
                ;;

            /dev/md*)
                # Adding raid support
                if [ -x /scripts/local-top/mdadm ]
                then
                    [ -r /conf/conf.d/md ] && cp /conf/conf.d/md /conf/conf.d/md.orig
                    echo "MD_DEVS=$device " >> /conf/conf.d/md
                    /scripts/local-top/mdadm >>/boot.log
                    [ -r /conf/conf.d/md.orig ] && mv /conf/conf.d/md.orig /conf/conf.d/md
                fi
                ;;
        esac
    done
    unset IFS

    [ -n "$device" ] && devname="$device"

    [ -e "$devname" ] || continue

    if [ -n "${LIVE_MEDIA_OFFSET}" ]
    then
        loopdevname=$(setup_loop "${devname}" "loop" "/sys/block/loop*" "${LIVE_MEDIA_OFFSET}" '')
        devname="${loopdevname}"
    fi

    fstype=$(get_fstype "${devname}")

    if is_supported_fs ${fstype}
    then
        devuid=$(blkid -o value -s UUID "$devname")
        [ -n "$devuid" ] && grep -qs "\<$devuid\>" /var/lib/live/boot/devices-already-tried-to-mount && continue

        for _PARAMETER in ${LIVE_BOOT_CMDLINE}
        do
            case "${_PARAMETER}" in
                forcefsck)
                    FORCEFSCK="true"
                    ;;
            esac
        done

        if [ "${PERSISTENCE_FSCK}" = "true" ] ||  [ "${PERSISTENCE_FSCK}" = "yes" ] || [ "${FORCEFSCK}" = "true" ]
        then
            force=""
            if [ "$FORCEFSCK" = "true" ]
            then
                force="-f"
            fi

            fix="-a"
            if [ "$FSCKFIX" = "true" ] || [ "$FSCKFIX" = "yes" ]
            then
                fix="-y"
            fi

            fsck $fix $force ${devname} >> fsck.log 2>&1
        fi

        mount -t ${fstype} -o ro,noatime "${devname}" ${mountpoint} || continue
        [ -n "$devuid" ] && echo "$devuid" >> /var/lib/live/boot/devices-already-tried-to-mount

        if [ -n "${FROMISO}" ]
        then
            if [ -f ${mountpoint}/${FROMISO} ]
            then
                umount ${mountpoint}
                mkdir -p /run/live/findiso
                for _p in $(cat /proc/cmdline);do
                    case ${_p} in
                        auto-deepin-installer|auto-installer)
                            RWFLAG="rw"
                            ;;
                    esac
                done
                if [ "${RWFLAG}" = "rw" ];then
                    if [ "${fstype}" = "ntfs" ];then
                        modprobe fuse
                        # Remove windows hibernatioin files, or else ntfs-3g
                        # will mount volume with read-only permission.
                        #mount.ntfs-3g -o remove_hiberfile,rw "${devname}" /live/findiso
                        mount.ntfs-3g -o rw "${devname}" /run/live/findiso
                    else
                        mount -t ${fstype} -o rw,noatime "${devname}" /run/live/findiso
                    fi
                else
                    mount -t ${fstype} -o ro,noatime "${devname}" /run/live/findiso
                fi
                loopdevname=$(setup_loop "/run/live/findiso/${FROMISO}" "loop" "/sys/block/loop*" 0 "")
                devname="${loopdevname}"
                mount -t iso9660 -o ro,noatime "${devname}" ${mountpoint}
            else
                umount ${mountpoint}
            fi
        fi

        if is_live_path ${mountpoint} && \
            ([ "${skip_uuid_check}" ] || matches_uuid ${mountpoint})
                then
                    echo ${mountpoint}
                    return 0
                else
                    umount ${mountpoint} 2>/dev/null
        fi
    fi

    if [ -n "${LIVE_MEDIA_OFFSET}" ]
    then
        losetup -d "${loopdevname}"
    fi

    return 1
}

