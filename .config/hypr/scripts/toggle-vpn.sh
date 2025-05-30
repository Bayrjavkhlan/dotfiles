#!/bin/bash

export DISPLAY=:0
export XDG_RUNTIME_DIR=/run/user/$(id -u)

WG_QUICK= /home/zero/.config/hypr/scripts/toggle-vpn.sh
IP="/usr/bin/ip"

if sudo $IP link show wg0 &>/dev/null; then
    notify-send "Turning VPN OFF"
    sudo $WG_QUICK down wg0
else
    notify-send "Turning VPN ON"
    sudo $WG_QUICK up wg0
fi

# enig butsaj ochij bgad eswel neg note ewdersench hamagu gsn uyde l oroldooroi