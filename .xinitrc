export XDG_CONFIG_HOME=/home/micro/.config
compton -cCGf &
xrdb ${XDG_CONFIG_HOME}/xresources
xmodmap ${XDG_CONFIG_HOME}/xmodmap
xset +fp ${XDG_CONFIG_HOME}/../.fonts
xset fp rehash
xrandr --dpi 227
sxhkd &
urxvtd -q -o -f
urxvtc -name kuake -pe default,matcher,kuake\<XF86LaunchA\> &
urxvt -pe default,matcher,-kuake -name weechat -e weechat &
urxvt -pe default,matcher,-kuake -name twitter -e turses &
mount /mnt/dropbox && hsetroot -fill /mnt/dropbox/Dropbox/images/wallpapers/9.png
firefox &
exec bspwm
