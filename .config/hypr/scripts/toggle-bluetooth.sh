#!/bin/bash

# Check current Bluetooth power state
POWER_STATE=$(bluetoothctl show | grep "Powered:" | awk '{print $2}')

if [ "$POWER_STATE" = "yes" ]; then
    # Turn Bluetooth OFF
    bluetoothctl power off
    notify-send "Bluetooth" "Turned OFF"
else
    # Turn Bluetooth ON
    bluetoothctl power on
    notify-send "Bluetooth" "Turned ON"
fi
