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
#~/bin/polybar/polybar-bsp.sh -r
~/bin/polybar/launch.sh &
