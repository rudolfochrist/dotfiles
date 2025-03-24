# Colors
autoload -U colors && colors
setopt prompt_subst

# Show completions
setopt menucomplete

# Load basic completions
autoload -Uz compinit && compinit
autoload -Uz bashcompinit && bashcompinit # compgen in zsh
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
if [ -x '/opt/local/bin/gls' ]; then
    alias ls='gls'
    alias l='ls -1pv --color=auto'
    alias ll='ls -lhv --color=auto'
    alias la='ll -A'
else
    alias l='ls -1p'
    alias ll="ls -lhG"
    alias la="ls -lAhG"
fi

# application shortcuts
alias g="git"

if [[ -x "/opt/local/bin/gmake" ]]; then
    alias make="gmake"
fi

if [[ -x "/opt/local/bin/gm4" ]]; then
    alias m4="gm4"
fi

# homegit
alias homegit="GIT_DIR=~/.dotfiles/.git GIT_WORK_TREE=~ git"

# VCS
autoload -Uz vcs_info
precmd () { vcs_info }
setopt prompt_subst

# Prompt
PS1="[%n@%M\$vcs_info_msg_0_ %1~]%# "

# 12 FEB 2025
# Not sure if this is still necessary?
# # SSH Agent
# # https://unix.stackexchange.com/questions/90853/how-can-i-run-ssh-add-automatically-without-password-prompt/217223#217223
# if [ "$(uname -s)" != 'Darwin' ]; then
#   if [ ! -S $HOME/.ssh/ssh_auth_sock ]; then
#      eval "$(ssh-agent -s)"
#      ln -sf "$SSH_AUTH_SOCK" $HOME/.ssh/ssh_auth_sock
#   fi
#   export SSH_AUTH_SOCK=$HOME/.ssh/ssh_auth_sock
#   ssh-add -l > /dev/null || ssh-add
# fi

# colors for ls
export CLICOLOR=1
export LSCOLORS='gxfxcxdxbxegedabagacad'

# chruby
if [[ -e "/opt/local/share/chruby" ]]; then
    source /opt/local/share/chruby/chruby.sh
    source /opt/local/share/chruby/auto.sh
fi

# perl local::lib
if [[ -e "$HOME/perl5/" ]]; then
    eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
fi

# direnv
if [[ -e "$(command -v direnv)" ]]; then
    eval "$(direnv hook zsh)"
fi
