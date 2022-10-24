# ~/.zshrc

# shell speed profiling
# run `ZPROF=true zsh` to benchmark
if [[ "$ZPROF" = true ]]; then
  zmodload zsh/zprof
fi

# vanilla zsh options
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=1000000            # i dont want to run out of history
SAVEHIST=1000000            # save it all, spare no disk space
setopt extended_history     # add timestamps to history
setopt append_history       # add to history instead of overwriting it
setopt inc_append_history   # ^ same but better
setopt share_history        # share history between shells
setopt hist_find_no_dups    # dont display duplicates when searching
setopt hist_reduce_blanks   # remove blank lines from history
setopt histignorespace      # ignore commands starting with a space
unsetopt hist_verify        # immediately run commands from history
setopt globdots             # match hidden files without explicitly specifying .
setopt extendedglob         # better globbing
setopt nocaseglob           # case insensitive glob
unsetopt notify             # make background jobs actually background
setopt correct              # autocorrect
setopt correct_all          # autocorrect more
setopt autocd               # cd to directory without writing cd
unsetopt bg_nice            # dont run background jobs at lower priority
unsetopt hup                # keep background jobs running even if shell is killed
setopt complete_in_word     # autocomplete anywhere in word
setopt always_to_end        # always move cursor to end of word when completing
setopt auto_menu            # automatically use menu completion
setopt auto_list            # automatically list choices
setopt auto_param_slash     # add slash to directories

# load colors? (i dont know if this is needed)
autoload -Uz colors && colors

# automatically quote urls
autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

# Use lf to switch directories
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp" >/dev/null
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
# bind it to ctrl-o
bindkey -s '^o' 'lfcd\n'

# ctrl-f to fzf search
bindkey -r '^f'
bindkey -s '^f' 'cd "$(dirname "$(fzf)")"\n'

# aliases
alias ls="ls --color=auto"
alias pac="sudo pacman"
alias untar="tar -zxvf"
alias mv="mv -iv"
alias rm="rm -I"
alias cp="cp -iv"
alias ln="ln -iv"
alias please='sudo $(fc -ln -1)'
#alias docker="sudo docker"
#alias docker-compose="sudo docker-compose"
alias lf="lfub"
alias gs="git status"

# move around blazingly fast!!
alias c="cd ~/.config"
alias b="cd ~/bin"
alias h="cd ~/"
function s() {
    cd ~/src/$1
}

# Install zinit if not installed
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# check that this shit is downloaded
if [[ -z $commands[thefuck] ]]; then
    echo 'thefuck is not installed, you should "pip install thefuck" or "brew install thefuck" first.'
    echo 'See https://github.com/nvbn/thefuck#installation'
fi

# OMZ plugins and libs
# install pkgfile and run `pkgfile --update` for command-not-found plugin to work
zinit wait lucid for \
    OMZL::clipboard.zsh \
    OMZL::compfix.zsh \
    OMZL::correction.zsh \
    OMZL::directories.zsh \
    OMZL::key-bindings.zsh \
    OMZP::command-not-found \
    OMZP::colored-man-pages

# extra completion
zinit wait lucid for \
  as"completion" \
    https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker \
  as"completion" \
    OMZP::docker-compose/_docker-compose

# basic setup
zinit wait lucid for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
  blockf \
  atpull"zinit creinstall -q .; zinit cclear" \
    zsh-users/zsh-completions \
  atinit"ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20" \
  atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions

# extra plugins
zinit wait lucid for \
  atload"
  HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND='bg=blue,fg=white,bold'
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  " \
    zsh-users/zsh-history-substring-search \
  bindmap"^R -> ^H" atinit"
  zstyle :history-search-multi-word page-size 10
  zstyle :history-search-multi-word highlight-color fg=red,bold
  zstyle :plugin:history-search-multi-word reset-prompt-protect 1
  " \
    zdharma/history-search-multi-word \
  as"program" pick"bin/git-dsf" \
    zdharma-continuum/zsh-diff-so-fancy \
    redxtech/zsh-asdf-direnv \
    djui/alias-tips \
  atload"
  zstyle ':prezto:module:thefuck' alias 'fuck'
  zstyle ':prezto:module:thefuck' bindkey 'no'
  zstyle ':prezto:runcom' zpreztorc '${ZDOTDIR:-$HOME}/.zshrc'
  " \
    laggardkernel/zsh-thefuck \
  atload"zstyle ':completion:*' format '%d'" \
    Aloxaf/fzf-tab

# starship.rs prompt
zinit ice from"gh-r" as"command" atload'eval "$(starship init zsh)"'
zinit load starship/starship

# get nice ls colors
zinit ice as"command" from"gh-r" mv"*-x86_64-unknown-linux-gnu/vivid -> vivid" bpick"*-x86_64-unknown-linux-gnu.tar.gz" pick"vivid"
zinit load sharkdp/vivid
# choose ls color scheme here
# `vivid themes` to see what's available)
THEME=snazzy
export LS_COLORS="$(vivid generate $THEME)"

# zstyle
# many of these are ignored by fzf-tab
# but they're here in case i want to turn that off
zstyle ':completion:*' completer _complete _correct
zstyle ':completion:*' verbose yes
zstyle ':completion:*' special-dirs false
zstyle ':completion:*' rehash true
zstyle ':completion:*' group-name ''
zstyle ":completion:*" list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path "${ZDOTDIR:-$HOME}/.zcompcache"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

# print benchmarking information if profiling
if [[ "$ZPROF" = true ]]; then
  zprof
fi
