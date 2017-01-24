# editor
export EDITOR="vim"

# Locale setup
export LANG=en_US.UTF-8

# load local environment
[[ -e ~/.zshenv.local ]] && source ~/.zshenv.local

# remove possibly duplicated entries from $PATH
typeset -U PATH
