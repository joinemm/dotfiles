#!/bin/sh
export PATH=$PATH:~/bin:~/bin/status
export TERM=alacritty
export EDITOR=nvim

SUDO_ASKPASS=$HOME/bin/rofi-askpass
SSH_ASKPASS=$HOME/bin/rofi-askpass

# turn off system beep
xset b off
xset b 0 0 0

# set higher key repeat rate
xset r rate 300 30

# source Xresources
[[ -f ~/.Xresources ]] && xrdb ~/.Xresources

# launch background processes
dwmblocks &
transmission-daemon
flameshot &
redshift &
[[ -f /opt/activitywatch/start.sh ]] && /opt/activitywatch/start.sh &

# run hostname specific config
# the automatic $HOST env variable is not set by zsh at this point yet
export HOSTNAME=$(cat /etc/hostname)
[[ -f ~/.init-$HOSTNAME ]] && . ~/.init-$HOSTNAME

# set wallpaper
~/.fehbg

# keyring
# see https://unix.stackexchange.com/a/295652/332452
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
# see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
# see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
mkdir -p "$HOME"/.local/share/keyrings

source ~/.config/lf/icons

# fix java programs
export _JAVA_AWT_WM_NONREPARENTING=1

# run dwm in a loop
while true; do
	dwm 2> ~/.dwm.log
done
