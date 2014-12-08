compton -cG &
xrdb -merge ${HOME}/.Xresources
xset +fp ${HOME}/.fonts
xset fp rehash
sxhkd &
urxvtd -q -o -f
urxvtc -name kuake -pe default,matcher,tabbed,kuake\<F11\> &
# caps lock is now control
sudo setkeycodes 3a 29
exec bspwm
