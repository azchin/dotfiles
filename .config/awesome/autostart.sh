#!/bin/sh

. ~/.config/profile

# kwallet
NIX_KWALLET_PAM=/etc/kwallet-pam-path
if [ -f "$NIX_KWALLET_PAM" ]; then
    $(cat $NIX_KWALLET_PAM)/libexec/pam_kwallet_init --unset QT_PLUGIN_PATH &> ~/sandbox/pam_kwallet_init.log
fi

# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
# export XMODIFIERS=@im=fcitx

# export GTK_IM_MODULE=ibus
# export QT_IM_MODULE=ibus
# export XMODIFIERS=@im=ibus

# special resets
# autorandr --change
# redshift -x

# kill services
killall dunst 
# killall -q sxhkd
# pkill redshift
# pkill udiskie
# pkill onedrive
pkill xss-lock
# pkill xidlehook
pkill cbatticon
# pkill pasystray
# pkill udisksctl
pkill nm-applet
# pkill devilspie2
# tmux kill-server
# killall -q fcitx
setxkbmap -option
# killall -q xscreensaver
# killall -q sleep_timer.sh
killall -q emacs
pkill picom

# services
# ~/bin/asound.sh off
# ~/bin/screens.sh
# sudo ~/bin/amdgpu-clock.sh

# ~/bin/wallpaper.sh
# xrandr --dpi 96
# xset b off
xset s 3600 3600
xset dpms 3600 3600 3600
# xsetroot -cursor_name left_ptr &
# redshift &
# autorandr --change &
# xcalib -d :0 "/usr/share/color/icc/Lenovo T520.icm" &
# xscreensaver &

dunst &
emacs --daemon &
[ -z "$(pidof playerctld)" ] && playerctld daemon &
# [ -z "$(pidof syncthing)" ] && syncthing &
setxkbmap -option caps:escape_shifted_capslock
xmodmap ~/.config/xmodmap
# sxhkd &
# pipewire &
# pipewire-pulse &
# wireplumber &
nm-applet &
xss-lock -l ~/bin/lock.sh & 
picom &
# [ -z "$(pidof keepassxc)" ] && keepassxc &
[ -z "$(pidof nextcloud)" ] && nextcloud &
# xrdb ~/.config/X11/Xresources
# cp ~/.config/gtk-3.0/settings-nixone.ini ~/.config/gtk-3.0/settings.ini

# [ -z "$(pidof xfce4-power-manager)" ] && xfce4-power-manager &
# sxhkd ~/.config/sxhkd/floating-sxhkdrc &
# udiskie -At &
# keepassxc &
# ibus-daemon -drxR
# fcitx5 -d
# pasystray &
cbatticon -n -u 10 -l 30 -o 'dunstify "Low battery!"' &
# megasync &
# devilspie2 &

# [ -z "$(pidof urxvtd)" ] && urxvtd &
#xset m 4/5 1
# fcitx &
# udisksctl monitor &
# find setxkbmap options in /usr/share/X11/xkb/rules/base.lst
# setxkbmap -option caps:super
# xcape -e 'Super_L=Escape' -t 200
# setxkbmap -option ctrl:nocaps
# xcape -e 'Control_L=Escape' -t 200
# tmux new -s andrew -d 
# onedrive -m &
# light-locker &
# xidlehook.sh &
# light-locker --lock-on-suspend --lock-after-screensaver=60 --idle-hint &
# light-locker --late-locking --lock-on-suspend --lock-after-screensaver=25 &

# instructions
# nmcli -g SSID device wifi list > "$XDG_CACHE_HOME"/ssidlist
# sleep_timer.sh &

# jack_control start
# qjackctl &
# cadence-session-start -s &
