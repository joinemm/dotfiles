#!/bin/sh

TERM=alacritty
EDITOR=nvim

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

monitor-setup
xset r rate 300 30
xrdb /home/join/.Xresources

~/.fehbg

#picom -b
dunst &
sxhkd &
dwmblocks &
transmission-daemon
flameshot &
/opt/activitywatch/start.sh &


while true; do
	dwm 2> ~/.dwm.log
done
