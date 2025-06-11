#!/bin/bash

TARGET_MAC="41:42:2E:93:3C:B5"

# Scan for 30 seconds
bluetoothctl scan on &
SCAN_PID=$!
sleep 30
kill $SCAN_PID
bluetoothctl scan off

# Check if device found nearby
if bluetoothctl devices | grep -iq "$TARGET_MAC"; then
    # Check if device connected to this computer
    if bluetoothctl info "$TARGET_MAC" | grep -q "Connected: yes"; then
        hyprctl notify 1 5000 "rgb(00ff00)" "🔊 Device $TARGET_MAC is connected."
    else
        hyprctl notify 1 5000 "rgb(ffff00)" "⚠ Device $TARGET_MAC found but not connected. Connect manually."
    fi
else
    hyprctl notify 1 5000 "rgb(ff0000)" "❌ Device $TARGET_MAC not found nearby."
fi
