#!/bin/bash
systemctl --user restart pipewire pipewire-pulse wireplumber
notify-send "PipeWire Restarted" "Audio services have been restarted."
