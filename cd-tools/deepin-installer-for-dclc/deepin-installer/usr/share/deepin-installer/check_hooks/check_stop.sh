#!/bin/bash

. "/deepin-installer/basic_utils.sh"

clean_disk_cryption() {
    local crypt_initramfs=$workspace/etc/cryptsetup-initramfs/conf-hook
    local cryp_conf_file=/etc/crypttab
    local key_file=/etc/deepin/crypt_keyfile_*.key

    [ -f ${crypt_initramfs}.real ] && mv ${crypt_initramfs}.real ${crypt_initramfs}
    [ -f ${cryp_conf_file}.real ] && mv ${cryp_conf_file}.real ${cryp_conf_file}
    rm -fr $key_file
    /usr/sbin/update-initramfs -u
}

# remove check mode files and test user
clean_check_mode() {
    userdel -rf ${SI_USERNAME}
    rm -rf /deepin-installer
    installer_set "system_check_mode" "false"
}

[ -n "$(installer_get "DI_CRYPT_PASSWD")" ] && clean_disk_cryption
clean_check_mode
reboot
