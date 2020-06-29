#!/bin/sh

# profile file symlinked to all shells
# runs on login

echo "$(date --rfc-3339=seconds) $0 - .bash_profile" >> ~/.startup.log

# program definitions for easy switching
export EDITOR="nvim"
export TERMINAL="alacritty"

# fix DPI scaling
export WINIT_X11_SCALE_FACTOR=1.0

# set path
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.7.0/bin:$HOME/.poetry/bin

# source api keys from drive
source $HOME/gdrive/keys

# source colors from color file
source $HOME/.config/colors

# start X if on tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi
