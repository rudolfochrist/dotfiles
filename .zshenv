# General
export DISPLAY=:0
export TERM=xterm-256color

# the env
export EDITOR="emacsclient -n"

# Locale setup
export LANG=en_US.UTF-8

# Add local/bin
export PATH="$HOME/.local/bin:$PATH"

# Set CC
export CC=cc

# remove possibly duplicated entries from $PATH
typeset -U PATH
