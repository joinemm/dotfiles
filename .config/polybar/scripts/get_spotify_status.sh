#!/bin/bash

if [ "$(playerctl status spotify)" = "Stopped" ]; then
    echo "No music is playing"
elif [ "$(playerctl status spotify)" = "Paused"  ]; then
    polybar-msg -p "$(pgrep -f "polybar main")" hook spotify-play-pause 2 &>/dev/null
    playerctl metadata spotify --format "{{ artist }} — {{ title }}" 2>/dev/null
else 
    polybar-msg -p "$(pgrep -f "polybar main")" hook spotify-play-pause 1 &>/dev/null
    playerctl metadata spotify --format "{{ artist }} — {{ title }}" 2>/dev/null
fi
