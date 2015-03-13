export XDG_CONFIG_HOME=/home/micro/.config
compton -f &
xrdb ${XDG_CONFIG_HOME}/xresources
xmodmap ${XDG_CONFIG_HOME}/xmodmaprc
xset +fp /home/micro/.local/share/fonts
xset fp rehash
sxhkd &
urxvtd -q -o -f
urxvtc -name kuake -pe default,selection,selection-to-clipboard,matcher,kuake\<XF86LaunchA\> &
hsetroot -fill /mnt/dropbox/Dropbox/images/wallpapers/9.png
firefox &
exec bspwm
