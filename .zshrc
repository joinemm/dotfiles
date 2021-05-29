# ~/.zshrc

path+=$HOME/bin
path+=$HOME/.local/bin
path+=$HOME/.yarn/bin
path+=$HOME/.poetry/bin
export PATH

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

setopt autocd extendedglob

# oh-my-zsh
export ZSH="/home/join/.oh-my-zsh"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"

plugins=(
	emoji
	command-not-found
	zsh-z # https://github.com/agkozak/zsh-z
	zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
	zsh-vi-mode # https://github.com/jeffreytse/zsh-vi-mode
	zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# aliases
source ~/.config/aliases

# prompt
eval "$(starship init zsh)"
