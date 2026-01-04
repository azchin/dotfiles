#!/bin/sh

. ~/.config/profile

NIX_KWALLET_PAM=/etc/kwallet-pam-path
if [ -f "$NIX_KWALLET_PAM" ]; then
    $(cat $NIX_KWALLET_PAM)/libexec/pam_kwallet_init --unset QT_PLUGIN_PATH &> ~/sandbox/pam_kwallet_init.log
fi

killall dunst
killall waybar
pkill nm-applet

sleep 0.5
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP && systemctl --user restart xdg-desktop-portal-gtk xdg-desktop-portal

WALLPAPER_DIR=~/drive/pictures/wallpapers
swaybg -o DP-1 -m fill -i $WALLPAPER_DIR/wp9494969.jpg &
swaybg -o HDMI-A-1 -m fill -i $WALLPAPER_DIR/wp12199669.jpg &

LOCK_TIMEOUT=600
swayidle -w \
         timeout $LOCK_TIMEOUT 'swaylock -f' \
         before-sleep 'swaylock -f' &
dunst &
GIO_EXTRA_MODULES="" waybar & # may race against portal
[ -z "$(pidof playerctld)" ] && playerctld daemon &

sleep 2

nm-applet &
[ -z "$(pidof keepassxc)" ] && keepassxc &
[ -z "$(pidof nextcloud)" ] && nextcloud &
xrdb ~/.config/X11/Xresources
xrdb -merge ~/.config/X11/Xresources-wayland
