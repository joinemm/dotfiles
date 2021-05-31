# ~/.zshrc

if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

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
ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.config/zsh-custom
ZSH_DISABLE_COMPFIX="true"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"
DISABLE_UNTRACKED_FILES_DIRTY="true"
ZSH_AUTOSUGGEST_USE_ASYNC="true"
ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd history completion)

plugins=(
	emoji
	command-not-found
	# fastcomp
	zsh-z # https://github.com/agkozak/zsh-z
	zsh-autosuggestions # https://github.com/zsh-users/zsh-autosuggestions
	zsh-vi-mode # https://github.com/jeffreytse/zsh-vi-mode
	zsh-syntax-highlighting # https://github.com/zsh-users/zsh-syntax-highlighting
)

### Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish
### Fix slowness of pastes

source $ZSH/oh-my-zsh.sh

# aliases
source ~/.config/aliases

if [[ "$ZPROF" = true ]]; then
  zprof
fi

# prompt
eval "$(starship init zsh)"
