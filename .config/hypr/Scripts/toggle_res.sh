#!/usr/bin/env bash

# --- Configuration ---
# Monitor Names (Check `hyprctl monitors` if unsure)
PRIMARY="DP-4"
SECONDARY="DP-5"

# Primary Monitor Modes
# Mode A: Work (4K @ 160Hz, 1.5 Scale)
MODE_WORK_RES="3840x2160@160"
MODE_WORK_SCALE="1.5"
# Logical width: 3840 / 1.5 = 2560
MODE_WORK_POS_SEC="2560x0"

# Mode B: Gaming (1080p @ 160Hz, 1.0 Scale)
# Note: Keeping 160Hz for gaming if supported at 1080p
MODE_GAME_RES="1920x1080@160"
MODE_GAME_SCALE="1"
# Logical width: 1920 / 1 = 1920
MODE_GAME_POS_SEC="1920x0"

# Secondary Monitor Constant Config
# We only change the position (POS), not resolution or scale
SEC_RES="1920x1200@60"
SEC_SCALE="1"

# --- Logic ---

# Get current width of the primary monitor to determine state
CURRENT_WIDTH=$(hyprctl monitors -j | jq -r ".[] | select(.name == \"$PRIMARY\") | .width")

if [ "$CURRENT_WIDTH" == "3840" ]; then
    # 4K -> 1080p
    echo "Switching to Gaming Mode (1080p)..."
    hyprctl keyword monitor "$PRIMARY, $MODE_GAME_RES, 0x0, $MODE_GAME_SCALE"
    hyprctl keyword monitor "$SECONDARY, $SEC_RES, $MODE_GAME_POS_SEC, $SEC_SCALE"
    notify-send -u low -t 3000 "Display Mode" "Gaming (1080p)"

else
    # 1080p (or other) -> 4K
    echo "Switching to Work Mode (4K)..."
    hyprctl keyword monitor "$PRIMARY, $MODE_WORK_RES, 0x0, $MODE_WORK_SCALE"
    hyprctl keyword monitor "$SECONDARY, $SEC_RES, $MODE_WORK_POS_SEC, $SEC_SCALE"
    notify-send -u low -t 3000 "Display Mode" "Work (4K)"
fi

hyprpaper 
#hyprctl hyprpaper wallpaper "$PRIMARY,/home/ruddy/Pictures/wallpapers/leo-fm.jpg"
#hyprctl hyprpaper wallpaper "$SECONDARY,/home/ruddy/Pictures/wallpapers/leo-fm.jpg"
