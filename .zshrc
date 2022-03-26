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
HISTSIZE=1000000
SAVEHIST=1000000

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
	fast-syntax-highlighting 
	history-substring-search
	docker
	docker-compose
	fzf
)

# Fix slowness of pastes with syntax highlighting
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  zle -N self-insert url-quote-magic # I wonder if you'd need `.url-quote-magic`?
}

pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# use oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
# bind up and down arrows to search through history with the current input
bindkey "^[[A" history-substring-search-up
bindkey "^[[B" history-substring-search-down
zle -N history-substring-search-up
zle -N history-substring-search-down

bindkey -s '^o' 'lfcd\n'
bindkey -s '^a' 'bc -lq\n'
bindkey -r '^f'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

# aliases
source ~/.config/aliases

if [[ "$ZPROF" = true ]]; then
  zprof
fi

# prompt
eval "$(starship init zsh)"
