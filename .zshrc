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
alias ec="emacsclient -n"

# homegit
alias homegit="GIT_DIR=~/.dotfiles/.git GIT_WORK_TREE=~ git"

# load more aliases
[[ -e ~/.zsh_aliases ]] && . ~/.zsh_aliases

# VCS
autoload -Uz vcs_info
precmd () { vcs_info }
setopt prompt_subst

# Prompt
PS1="[%n@%M\$vcs_info_msg_0_ %1~]%# "

# perlbrew
if [ -s $HOME/perl5/perlbrew ]; then
    source ~/perl5/perlbrew/etc/bashrc
fi

# C REPL (kinda)
RUNC_LIBS="-lm"
RUNC_FLAGS="-g -Wall -include ~/prj/allheads/allheads.h -O3"
alias runc="gcc -xc - $RUNC_LIBS $RUNC_FLAGS"

# SSH Agent
# https://unix.stackexchange.com/questions/90853/how-can-i-run-ssh-add-automatically-without-password-prompt/217223#217223
if [ ! -S $HOME/.ssh/ssh_auth_sock ]; then
    eval "$(ssh-agent -s)"
    ln -sf "$SSH_AUTH_SOCK" $HOME/.ssh/ssh_auth_sock
fi
export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add


# load local configuration
[[ -e ~/.zshrc.local ]] &&  source ~/.zshrc.local

