# Colors
autoload -U colors && colors
setopt prompt_subst

# Show completions
setopt menucomplete

# Load basic completions
autoload compinit && compinit

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

# emacs keybindings
bindkey -e

# navigation
alias ll="ls -lh --color"
alias la="ls -lah --color"
alias lla="ls -lah | less"
alias ..="cd .."

# application shortcuts
alias g="git"
alias npmls="npm ls -g --depth=0"
alias skim="open -a Skim"
alias ec="emacsclient"
alias xgd-open="open"

# homegit
alias homegit="GIT_DIR=~/prj/dotfiles/.git GIT_WORK_TREE=~ git"

# Prompt
autoload -U promptinit
promptinit
prompt redhat

# perlbrew
source ~/perl5/perlbrew/etc/bashrc
alias pb="perlbrew"

# C REPL (kinda)
RUNC_LIBS="-lm"
RUNC_FLAGS="-g -Wall -include ~/prj/allheads/allheads.h -O3"
alias runc="gcc -xc - $RUNC_LIBS $RUNC_FLAGS"

### load local configuration
[[ -e ~/.zshrc.local ]] &&  source ~/.zshrc.local
