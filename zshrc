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
alias ..="cd .."

# application shortcuts
alias g="git"
alias npmls="npm ls -g --depth=0"

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

### OSX
if [[ "Darwin" = $(uname -s) ]]; then
   
    # check for coreutils ls (mac homebrew installs gnu ls to gls)
    if [[ -f $(which gls) ]]; then
        alias ls="gls"
    fi

    alias skim="open -a Skim"
    alias fresh-emacs="open -na Emacs"
    alias xgd-open="open"

fi

### load local configuration
[[ -e ~/.zshrc.local ]] &&  source ~/.zshrc.local
