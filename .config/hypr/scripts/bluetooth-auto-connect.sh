#!/bin/bash

TARGET_MAC="41:42:2E:93:3C:B5"

# Start scanning in the background
bluetoothctl scan on &

echo "🔍 Scanning for $TARGET_MAC..."

while true; do
    # Check if the device is found
    if bluetoothctl devices | grep -iq "$TARGET_MAC"; then
        echo "✅ Device $TARGET_MAC found."

        # Try to connect
        if bluetoothctl info "$TARGET_MAC" | grep -q "Connected: yes"; then
            echo "🔊 Already connected to $TARGET_MAC."
            hyprctl notify 1 5000 "rgb(00ff00)" "🔊 $TARGET_MAC connected."
        else
            echo "🔗 Connecting to $TARGET_MAC..."
            bluetoothctl connect "$TARGET_MAC" >/dev/null

            # Check again if connection was successful
            if bluetoothctl info "$TARGET_MAC" | grep -q "Connected: yes"; then
                echo "✅ Connected to $TARGET_MAC!"
                hyprctl notify 1 5000 "rgb(00ff00)" "✅ Connected to $TARGET_MAC."
            else
                echo "❌ Failed to connect to $TARGET_MAC."
                hyprctl notify 1 5000 "rgb(ff0000)" "❌ Failed to connect to $TARGET_MAC."
            fi
        fi

        # Once connected or attempt finished, stop scanning and exit
        bluetoothctl scan off
        break
    fi

    sleep 0.5  # short delay before checking again
done
