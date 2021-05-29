#!/bin/sh

# ~/.xinitrc

TERM=alacritty
EDITOR=nvim

# set resolution and refresh rate
~/bin/monitor-setup

# remap caps lock to super and set higher key repeat rate
setxkbmap -option caps:super
xset r rate 300 30

# source Xresources
xrdb /home/join/.Xresources

# set wallpaper
~/.fehbg

# launch background processes
dunst &
#sxhkd &
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
