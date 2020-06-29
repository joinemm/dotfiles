#!/bin/sh

echo "$(date --rfc-3339=seconds) $0 - .bashrc" >> ~/.startup.log

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Infinite history
HISTSIZE= HISTFILESIZE= 

# prompt
export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

# load shortcuts and aliases
[ -f "$HOME/.config/shortcutrc" ] && source "$HOME/.config/shortcutrc"
[ -f "$HOME/.config/aliasrc" ] && source "$HOME/.config/aliasrc"
