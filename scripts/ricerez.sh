#!/bin/sh

pkill sxhkd
pkill dunst
pkill picom
pkill onedrive
killall -q polybar

sxhkd &
dunst &
picom -CGb
onedrive -m &
#onedrive -m --confdir ~/.config/onedrive/config_personal &
~/scripts/polybar-bsp.sh -r
~/.config/polybar/launch.sh &
