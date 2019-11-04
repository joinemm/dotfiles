#!/bin/sh
#
# profile file symlinked to all shells
# runs on login

# program definitions
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER="firefox-developer-edition"
export FILEM="pcmanfm"

# set path
export PATH=$PATH:$HOME/bin:$HOME/.local/bin

# source api keys from dropbox
source $HOME/Dropbox/keys

# source colors from color file
source $HOME/.config/colors

# source bashrc but only if shell is bash
echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# start X
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi
