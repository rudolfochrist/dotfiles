# editor
export EDITOR="vim"

# Locale setup
export LANG=en_US.UTF-8

# NodeJS
export NODE_PATH=/usr/local/lib/node_modules
export PATH="/usr/local/share/npm/bin:$PATH"

if [[ -e /usr/libexec/java_home ]]; then
    # JAVA_HOME
    export JAVA_HOME="$(/usr/libexec/java_home)"
fi

# Maven Home
export M2_HOME=/usr/local/opt/maven/libexec

# Groovy
export GROOVY_HOME=/usr/local/opt/groovy/libexec

# load local environment
if [[ -e ~/.zshenv.local ]]; then
    source ~/.zshenv.local
fi

# remove possibly duplicated entries from $PATH
typeset -U PATH
