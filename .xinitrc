#!/usr/bin/env bash
# vim: ft=sh

export TERM=kitty
export EDITOR=nvim

# turn off system beep
xset b off
xset b 0 0 0

# source Xresources
xrdb ~/.Xresources

# launch background processes
dwmblocks &
dunst &
picom -b
flameshot &

# set wallpaper
# [[ -f ~/.keys ]] && source ~/.keys
# random-wallpaper
~/.fehbg

# see https://unix.stackexchange.com/a/295652/332452
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh
# see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
# see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
mkdir -p $HOME/.local/share/keyrings

# icons for lf file manager
source ~/.config/lf/icons

# fix java programs in tiling window managers
export _JAVA_AWT_WM_NONREPARENTING=1

# run hostname specific config
# the automatic $HOST env variable is not set by zsh at this point yet
export HOSTNAME=$(cat /etc/hostname)
[[ -f ~/.init-$HOSTNAME ]] && . ~/.init-$HOSTNAME

# run dwm in a loop
while true; do
    dwm 2>~/.dwm.log
done
