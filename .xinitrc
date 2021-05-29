#!/bin/sh

TERM=alacritty
EDITOR=nvim

# set higher key repeat rate
xset r rate 300 30

# source Xresources
xrdb /home/join/.Xresources

# set wallpaper
~/.fehbg

# launch background processes
dunst &
dwmblocks &
transmission-daemon
flameshot &
/opt/activitywatch/start.sh &

# run hostname specific config
if [ -f ~/.init-$HOST ]; then
	source ~/.init-$HOST
fi

# run dwm in a loop
while true; do
	dwm 2> ~/.dwm.log
done
