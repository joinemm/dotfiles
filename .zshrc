# ~/.zshrc

if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

path+=$HOME/bin
path+=$HOME/.local/bin
path+=$HOME/.yarn/bin
path+=$HOME/.poetry/bin
path+=$HOME/.cargo/bin
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
	command-not-found
	zsh-autosuggestions 
	zsh-vi-mode 
	zsh-syntax-highlighting 
	history-substring-search
	docker
	docker-compose
)

# Fix slowness of pastes with zsh-syntax-highlighting.zsh
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# bind up and down arrows to search through history with the current input
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
zle -N history-substring-search-up
zle -N history-substring-search-down

# use oh-my-zsh
source $ZSH/oh-my-zsh.sh

# aliases
source ~/.config/aliases

if [[ "$ZPROF" = true ]]; then
  zprof
fi

# prompt
eval "$(starship init zsh)"
