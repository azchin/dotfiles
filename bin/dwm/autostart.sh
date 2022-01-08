#!/bin/sh

killall -q slstatus
killall -q sxhkd
killall -q xcompmgr

# ~/bin/autostart.sh

slstatus &
sxhkd &
xcompmgr &
