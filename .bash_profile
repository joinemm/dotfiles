#!/bin/sh

# profile file symlinked to all shells
# runs on login

# program definitions for easy switching
export EDITOR="nvim"
export TERMINAL="alacritty"
export TERM="alacritty"
export BROWSER="firefox"

# fix DPI scaling
export WINIT_X11_SCALE_FACTOR=1.0

# set path
export PATH=$PATH:$HOME/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.7.0/bin:$HOME/.poetry/bin

# start X if on tty1
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi
