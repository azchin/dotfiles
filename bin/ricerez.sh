#!/bin/sh

pkill sxhkd
pkill dunst
pkill picom
#pkill compton
pkill onedrive
killall -q polybar

sxhkd &
dunst &
picom -b
#compton &
onedrive -m &
#onedrive -m --confdir ~/.config/onedrive/config_personal &
~/bin/polybar-bsp.sh -r
~/.config/polybar/launch.sh &
