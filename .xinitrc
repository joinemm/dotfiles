#!/bin/sh

# runs on X init

echo "$(date --rfc-3339=seconds) $0 - .xinitrc" >> ~/.startup.log

# tiling wm fix for java programs like matlab
#export _JAVA_AWT_WM_NONREPARENTING=1

# remap caps lock to super
setxkbmap -option caps:super

# set faster key repeat rate
xset r rate 300 50

# disable bell
xset -b

# run X scripts set in etc if any are present
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# set wallpaper
~/.fehbg

# start programs
dunst &
picom &
sxhkd &

exec bspwm
