#!/bin/sh

killall -q slstatus
killall -q sxhkd
killall -q picom

# ~/bin/autostart.sh

slstatus &
sxhkd &
picom &
