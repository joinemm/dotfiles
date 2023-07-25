#!/bin/sh

typeset -U path PATH

path+=$HOME/bin
path+=$HOME/bin/rofi
path+=$HOME/bin/status
path+=$HOME/.local/bin
path+=$HOME/.yarn/bin
path+=$HOME/.poetry/bin
path+=$HOME/.cargo/bin

export PATH

# Python Better Exceptions
export BETTER_EXCEPTIONS=1

export EDITOR=nvim
export BROWSER=firefox
export FM=pcmanfm
