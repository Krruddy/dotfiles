#!/usr/bin/env zsh

# Name of your special workspace
SPECIAL_WS="magic"

# Get the monitor name where the special workspace currently resides
TARGET_MON=$(hyprctl workspaces -j | jq -r ".[] | select(.name == \"special:$SPECIAL_WS\") | .monitor")

# If the workspace exists and is on a different monitor, focus that monitor first
if [[ -n "$TARGET_MON" && "$TARGET_MON" != "null" ]]; then
    hyprctl dispatch focusmonitor "$TARGET_MON"
fi

# Toggle the workspace
hyprctl dispatch togglespecialworkspace "$SPECIAL_WS"
