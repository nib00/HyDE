#!/usr/bin/env bash

#--------------------------------#
# import variables and functions #
#--------------------------------#
scrDir="$(dirname "$(realpath "$0")")"
# shellcheck disable=SC1091
if ! source "${scrDir}/global_fn.sh"; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi
cat <<"EOF"
 ___ ___ ___ _ _|_|___ ___ ___
|_ -| -_|  _| | | |  _| -_|_ -|
|___|___|_|  \_/|_|___|___|___|

EOF

while read -r serviceChk; do

    if [[ $(sysctl list-units --all -t service --full --no-legend "${serviceChk}.service" | sed 's/^\s*//g' | cut -f1 -d' ') == "${serviceChk}.service" ]]; then
        print_log -y "[skip] " -b "active " "Service ${serviceChk}"
    else
        print_log -y "start" "Service ${serviceChk}"
        if [ $flg_DryRun -ne 1 ]; then
            sudo systemctl enable "${serviceChk}.service"
            sudo systemctl start "${serviceChk}.service"
        fi
    fi

done <./system_ctl.lst
