#!/bin/sh

pkill dunst
pkill xcompmgr
pkill redshift

pkill -USR1 -x sxhkd
polybar-msg cmd restart
dunst &
redshift &
xcompmgr &

#onedrive -m --confdir ~/.config/onedrive/config_personal &
#~/bin/polybar/polybar-bsp.sh -r
# ~/bin/polybar/launch.sh &
