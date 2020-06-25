#!/bin/sh

# fix matlab
#export _JAVA_AWT_WM_NONREPARENTING=1

setxkbmap -option caps:super
xset r rate 300 50
xset -b

# autostart programs
dunst &
~/.fehbg
picom &

# from default config. does something important
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# start hotkey daemon and lauch window manager
sxhkd -m 1 &
exec bspwm
