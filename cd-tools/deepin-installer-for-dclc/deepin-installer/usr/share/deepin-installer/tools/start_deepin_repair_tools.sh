#!/bin/bash

generate_lightdm_conf() {
  local CONF_FILE="/etc/lightdm/lightdm.conf"
  cat > "${CONF_FILE}" <<EOF
[Seat:*]
display-setup-script=/usr/bin/deepin-installer-bases
greeter-session=lightdm-installer-greeter
greeter-setup-script=/usr/sbin/deepin-repair-tools
EOF
}

generate_lightdm_conf
systemctl restart lightdm || systemctl restart lightdm
