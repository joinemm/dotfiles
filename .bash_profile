#!/bin/sh
#
# profile file symlinked to all shells
# runs on login

# program definitions
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox"
export FILEM="pcmanfm"

# fix DPI scaling
export WINIT_X11_SCALE_FACTOR=1.0

# set path
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.7.0/bin:$HOME/.poetry/bin

# source api keys from drive
source $HOME/gdrive/keys

# source colors from color file
source $HOME/.config/colors

# source bashrc but only if shell is bash
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# start X
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi
