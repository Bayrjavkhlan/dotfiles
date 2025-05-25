#!/bin/bash

# Opacity state file
STATE_FILE="/tmp/hypr-transparency"

# Default to opaque
if [ ! -f "$STATE_FILE" ]; then
    echo "opaque" > "$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")

if [ "$STATE" == "opaque" ]; then
    # Apply transparency
    hyprctl keyword windowrulev2 "opacity 0.9 0.9,class:^(firefox)$"
    hyprctl keyword windowrulev2 "opacity 0.9 0.9,class:^(code)$"
    hyprctl keyword windowrulev2 "opacity 0.8 0.8,class:^(spotify)$"
    hyprctl keyword windowrulev2 "opacity 0.8 0.8,class:^(.*)$"


    echo "transparent" > "$STATE_FILE"
    notify-send "Transparency" "Window transparency has been set to transparent."
else
    # Reset to opaque
    hyprctl keyword windowrulev2 "opacity 1.0 1.0,class:^(firefox)$"
    hyprctl keyword windowrulev2 "opacity 1.0 1.0,class:^(code)$"
    hyprctl keyword windowrulev2 "opacity 1.0 1.0,class:^(spotify)$"
    hyprctl keyword windowrulev2 "opacity 1.0 1.0,class:^(.*)$"


    echo "opaque" > "$STATE_FILE"
    notify-send "Transparency" "Window transparency has been reset to opaque."
fi

