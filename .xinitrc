#!/bin/sh

export TERM=alacritty
export EDITOR=nvim

# set higher key repeat rate
xset r rate 300 30

# source Xresources
[[ -f ~/.Xresources ]] && xrdb ~/.Xresources

# set wallpaper
~/.fehbg

# launch background processes
dunst &
dwmblocks &
transmission-daemon
flameshot &
[[ -f /opt/activitywatch/start.sh ]] && /opt/activitywatch/start.sh &

# run hostname specific config
# the automatic $HOST env variable is not set by zsh at this point yet
HOST="$(hostname)"
[[ -f ~/.init-$HOST ]] && . ~/.init-$HOST

# run dwm in a loop
while true; do
	dwm 2> ~/.dwm.log
done
