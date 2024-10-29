### Path

# see: https://apple.stackexchange.com/questions/432226/homebrew-path-set-in-zshenv-is-overridden

# Postgres
export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin/"

# Ada/gprbuild
export PATH="$PATH:$HOME/.local/share/alire/toolchains/gnat_native_13.2.1_c21501ad/bin:$HOME/.local/share/alire/toolchains/gprbuild_22.0.1_b1220e2b/bin"

# go binaries
export PATH="$PATH:$HOME/go/bin"

##
# Your previous /Users/lispm/.zprofile file was backed up as /Users/lispm/.zprofile.macports-saved_2024-08-05_at_14:12:15
##

# MacPorts Installer addition on 2024-08-05_at_14:12:15: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

# And local bin
export PATH="$HOME/.local/bin:$PATH"

# Remove duplicates
typeset -U PATH
