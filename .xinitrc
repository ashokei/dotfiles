compton -cG &
xrdb -merge ${HOME}/.Xresources
xset +fp ${HOME}/.fonts
xset fp rehash
sxhkd &
urxvtd -q -o -f
urxvtc -name kuake -pe default,matcher,kuake\<alt+`\> &
urxvt -pe default,matcher,-kuake -name weechat -e weechat &
urxvt -pe default,matcher,-kuake -name twitter -e turses &
unclutter &
firefox &
# caps lock is now control
sudo setkeycodes 3a 29
exec bspwm
