# Prepend /usr/local/bin
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"

# And local bin
export PATH="$HOME/bin:$PATH"

# Remove duplicates
typeset -U PATH
