# Lock screen
xautolock -locker slock &

# Sane keyboard settings. Space Cadet Style
setxkbmap -variant altgr-intl \
          -option altwin:ctrl_alt_win \
          -option compose:menu \
          -option caps:backspace

# Emulate middle click with Left+Right click
xinput set-prop 'Logitech M570' 'libinput Middle Emulation Enabled' 1

# enable mouse wheel
export GDK_CORE_DEVICE_EVENTS=1
