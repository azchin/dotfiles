#!/bin/sh
. ~/.config/profile
. ~/.config/aliases
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx
# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=ibus
# export XMODIFIERS=@im=ibus

killall pipewire
killall emacs
# killall fcitx5

[ -z "$(pidof urxvtd)" ] && urxvtd &
emacs --daemon &
keepassxc &
# ibus-daemon -drx --panel=/usr/lib/kimpanel-ibus-panel
# fcitx5 -d
pipewire &
# [ -z "$(pidof pipewire)" ] && pipewire &
# [ -z "$(pidof pipewire-media-session)" ] && pipewire-media-session &

# ln -s ~/.config/electron-flags-wayland.conf ~/.config/brave-flags.conf
# ln -s ~/.config/electron-flags-wayland.conf ~/.config/electron-flags.conf
