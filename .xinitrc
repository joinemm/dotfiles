#!/bin/sh

TERM=alacritty
EDITOR=nvim

# set up keyring for authentication
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

# set resolution and refresh rate
monitor-setup

# remap caps lock to super and set higher repeat rate
setxkbmap -option caps:super
xset r rate 300 30

# source X resources
xrdb /home/join/.Xresources

# set wallpaper
~/.fehbg

# launch background programs
dunst &
sxhkd &
dwmblocks &
transmission-daemon
flameshot &
/opt/activitywatch/start.sh &

# run dwm in a loop
while true; do
	dwm 2> ~/.dwm.log
done
