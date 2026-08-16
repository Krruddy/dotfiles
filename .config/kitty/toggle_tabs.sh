#!/bin/bash
CONF_FILE="$HOME/.config/kitty/kitty.conf"

# Check if currently hidden
if grep -q "include tab_bar_on.conf" "$CONF_FILE"; then
    # Switch to Visible
    sed -i 's/include tab_bar_on.conf/include tab_bar_off.conf/' "$CONF_FILE"
else
    # Switch to Hidden
    sed -i 's/include tab_bar_off.conf/include tab_bar_on.conf/' "$CONF_FILE"
fi

# Reload kitty config (applies to all instances immediately)
pkill -USR1 kitty
