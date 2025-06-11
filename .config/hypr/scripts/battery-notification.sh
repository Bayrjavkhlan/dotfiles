#!/bin/bash

STATEFILE="$HOME/.cache/battery-notify.state"
BATTERY=$(upower -i $(upower -e | grep BAT) | grep percentage | awk '{print $2}' | tr -d '%')

# Initialize state file if missing
if [ ! -f "$STATEFILE" ]; then
  echo "0 0 0 0" > "$STATEFILE"  # flags for 40,20,10,5
fi

read -r notified40 notified20 notified10 notified5 < "$STATEFILE"

# Function to update state file
update_state() {
  echo "$notified40 $notified20 $notified10 $notified5" > "$STATEFILE"
}

notify_and_flag() {
  local color=$1
  local icon=$2
  local message=$3
  local flag_var=$4

  hyprctl notify "$icon" 10000 "$color" "$message"
  eval "$flag_var=1"
  update_state
}

# Logic for 40%
if (( BATTERY <= 40 && notified40 == 0 )); then
  notify_and_flag "rgb(ffff00)" 1 "⚠ Battery <= 40%: ${BATTERY}%" notified40
elif (( BATTERY > 40 && notified40 == 1 )); then
  notified40=0
  update_state
fi

# Logic for 20%
if (( BATTERY <= 20 && notified20 == 0 )); then
  notify_and_flag "rgb(ffa500)" 0 "⚠ Battery <= 20%: ${BATTERY}%" notified20
elif (( BATTERY > 20 && notified20 == 1 )); then
  notified20=0
  update_state
fi

# Logic for 10%
if (( BATTERY <= 10 && notified10 == 0 )); then
  notify_and_flag "rgb(ff4500)" 0 "🟥 Battery <= 10%: ${BATTERY}%" notified10
elif (( BATTERY > 10 && notified10 == 1 )); then
  notified10=0
  update_state
fi

# Logic for 5%
if (( BATTERY <= 5 && notified5 == 0 )); then
  notify_and_flag "rgb(ff0000)" 0 "🟥 CRITICAL Battery <= 5%: ${BATTERY}%" notified5
elif (( BATTERY > 5 && notified5 == 1 )); then
  notified5=0
  update_state
fi

if (( notified == 0 )); then
  hyprctl notify 1 3000 "rgb(00ff00)" "🔋 Battery is healthy: ${BATTERY}%"
fi