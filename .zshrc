path+=$HOME/bin
path+=$HOME/.local/bin
path+=$HOME/.yarn/bin
path+=$HOME/.poetry/bin
export PATH

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd extendedglob

export ZSH="/home/join/.oh-my-zsh"

#ZSH_THEME="robbyrussell"
DISABLE_AUTO_UPDATE="true"

COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(zsh-z zsh-autosuggestions emoji zsh-vi-mode)

source $ZSH/oh-my-zsh.sh
source ~/.config/aliases
eval "$(starship init zsh)"
