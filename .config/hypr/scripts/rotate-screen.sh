#!/bin/bash

MONITOR="eDP-1"

# Disable visual effects temporarily
hyprctl keyword decoration:blur:enabled false
hyprctl keyword decoration:shadow:enabled false
hyprctl keyword animations:enabled false

# Allow compositor to apply changes
sleep 0.1

# Get current transform
CURRENT=$(hyprctl monitors | awk -v mon="$MONITOR" '
  $0 ~ mon {found=1}
  found && /transform:/ {
    print $2
    exit
  }
')

# Determine next transform
case "$CURRENT" in
  0) NEXT=1 ;;  # 90°
  1) NEXT=2 ;;  # 180°
  2) NEXT=3 ;;  # 270°
  3) NEXT=0 ;;  # back to normal
  *) NEXT=0 ;;
esac

# Apply rotation with existing scale
hyprctl keyword monitor "$MONITOR,preferred,auto,1.333333,transform,$NEXT"

# Let the system settle
sleep 0.5

# Restore visual effects
hyprctl keyword decoration:blur:enabled true
hyprctl keyword decoration:shadow:enabled true
hyprctl keyword animations:enabled true

# Optional: Notify
notify-send "Rotated to transform $CURRENT to $NEXT "
