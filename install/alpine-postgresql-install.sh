#!/usr/bin/env bash

# Copyright (c) 2021-2024 tteck
# Author: cusspvz (José Moreira)
# License: MIT
# https://github.com/tteck/Proxmox/raw/main/LICENSE
source /dev/stdin <<< "$FUNCTIONS_FILE_PATH"

color
verb_ip6
catch_errors
setting_up_container
network_check
update_os

msg_info "Installing Postgres"
$STD apk add --update postgres
$STD rc-service postgres start
$STD rc-update add postgres default
msg_ok "Installed Postgres"

motd_ssh
customize
