# Colors
autoload -U colors && colors
setopt prompt_subst

# Show completions
setopt menucomplete

# Load basic completions
autoload compinit && compinit
setopt magicequalsubst

# Completion Config
zstyle ":completion:*" use-cache on
zstyle ":completion:*" cache-path ~/.zsh/cache
zstyle ":completion:*" menu select
zstyle ":completion:*" verbose yes

# Correction
setopt CORRECT_ALL

# History
HISTFILE=$HOME/.zshhistory
setopt APPEND_HISTORY
HISTSIZE=1000
SAVEHIST=1000
setopt HIST_EXPIRE_DUPS_FIRST
setopt EXTENDED_HISTORY

# emacs 
bindkey -e
export EDITOR="emacsclient -n"

# Locale setup
export LANG=en_US.UTF-8

# navigation
# check for coreutils ls (mac homebrew installs gnu ls to gls)
if [[ -f $(which gls) ]]; then
    alias ls="gls"
fi

alias ll="ls -lh --color"
alias la="ls -lAh --color"
alias lla="ls -lAh | less"
alias ..="cd .."

# application shortcuts
alias g="git"
alias ec="emacsclient"

# homegit
alias homegit="GIT_DIR=~/.dotfiles/.git GIT_WORK_TREE=~ git"

# load more aliases
[[ -e ~/.zsh_aliases ]] && . ~/.zsh_aliases

# Prompt
autoload -U promptinit
promptinit
prompt redhat

# perlbrew
if [ -s $HOME/perl5/perlbrew ]; then
    source ~/perl5/perlbrew/etc/bashrc
fi 

# C REPL (kinda)
RUNC_LIBS="-lm"
RUNC_FLAGS="-g -Wall -include ~/prj/allheads/allheads.h -O3"
alias runc="gcc -xc - $RUNC_LIBS $RUNC_FLAGS"

# load local configuration
[[ -e ~/.zshrc.local ]] &&  source ~/.zshrc.local

# Add local/bin
export PATH="$HOME/.local/bin:$PATH"

# remove possibly duplicated entries from $PATH
typeset -U PATH
