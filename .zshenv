# editor
export EDITOR="emacsclient'

# Locale setup
export LANG=en_US.UTF-8

# Ada 2012 / GNAT GPL
export GNAT_HOME=/usr/local/gnat
export PATH="$GNAT_HOME/bin:$PATH" 

# load local environment
[[ -e ~/.zshenv.local ]] && source ~/.zshenv.local

# remove possibly duplicated entries from $PATH
typeset -U PATH
