#!/bin/bash
WAYBAR_CONFIG="$HOME/.config/waybar/config.jsonc"
WAYBAR_STYLE="$HOME/.config/waybar/style.css"

killall waybar 2> /dev/null
echo -e "$WAYBAR_CONFIG\n$WAYBAR_STYLE" | entr -s \
    "echo '重新加载waybar'; killall waybar 2> /dev/null; waybar &"