#!/bin/sh

# fix matlab
export _JAVA_AWT_WM_NONREPARENTING=1

# autostart programs
dunst &
compton --config ~/.config/compton/config &
dropbox &
~/.fehbg
xset r rate 300 50

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
