### Path

# see: https://apple.stackexchange.com/questions/432226/homebrew-path-set-in-zshenv-is-overridden

# And local bin
export PATH="$HOME/bin:$PATH"

# Lisp bin/
export PATH="$HOME/bin/lisp/bin:$PATH"

# Homebrew GNU Make
export PATH="/usr/local/opt/make/libexec/gnubin:$PATH"

# Homebrew Texinfo
export PATH="/usr/local/opt/texinfo/bin:$PATH"

# TeXTiny
export PATH=$PATH:$HOME/texbin

# Postgres
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin/"

# Remove duplicates
typeset -U PATH
