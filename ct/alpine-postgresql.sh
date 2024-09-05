#!/usr/bin/env bash
source <(curl -s https://raw.githubusercontent.com/tteck/Proxmox/main/misc/fs.func)
source <(fs_cat misc/build.func)
# Copyright (c) 2021-2024 tteck
# Author: cusspvz (José Moreira)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE

function header_info {
clear
cat <<"EOF"
    ____             __                 _____ ____    __
   / __ \____  _____/ /_____ _________ / ___// __ \  / /
  / /_/ / __ \/ ___/ __/ __  / ___/ _ \\__ \/ / / / / /
 / ____/ /_/ (__  ) /_/ /_/ / /  /  __/__/ / /_/ / / /___
/_/    \____/____/\__/\__, /_/   \___/____/\___\_\/_____/
                     /____/
EOF
}
header_info
echo -e "Loading..."
APP="Alpine-PostgreSQL"
var_disk="4"
var_cpu="1"
var_ram="1024"
var_os="alpine"
var_version="3.19"
variables
color
catch_errors

function default_settings() {
  CT_TYPE="1"
  PW=""
  CT_ID=$NEXTID
  HN=$NSAPP
  DISK_SIZE="$var_disk"
  CORE_COUNT="$var_cpu"
  RAM_SIZE="$var_ram"
  BRG="vmbr0"
  NET="dhcp"
  GATE=""
  APT_CACHER=""
  APT_CACHER_IP=""
  DISABLEIP6="no"
  MTU=""
  SD=""
  NS=""
  MAC=""
  VLAN=""
  SSH="no"
  VERB="no"
  echo_default
}

function update_script() {
header_info
msg_info "Updating ${APP} LXC"
apk update && apk upgrade
service postgres restart
msg_ok "Updated Successfully"
exit
}

start
build_container
description

msg_ok "Completed Successfully!\n"
echo -e "${APP} should be reachable by going to the following URL.
         ${BL}postgres://${IP}:5432/postgres \n"
