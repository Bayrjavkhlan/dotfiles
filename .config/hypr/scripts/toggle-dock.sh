#!/bin/bash

export GDK_BACKEND=wayland
export XDG_SESSION_TYPE=wayland
export QT_QPA_PLATFORM=wayland

flag="$HOME/.config/ml4w/settings/dock-disabled"
dock_launcher="$HOME/dotfiles/.config/nwg-dock-hyprland/launch.sh"

if [ -f "$flag" ]; then
    # Enable dock
    rm "$flag"
    notify-send "Dock Enabled"
    sleep 0.3
    "$dock_launcher" &
else
    # Disable dock
    touch "$flag"
    notify-send "Dock Disabled"
    pkill -f nwg-dock-hyprland
fi
