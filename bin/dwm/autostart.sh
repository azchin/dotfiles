#!/bin/sh

killall -q slstatus
killall -q sxhkd
killall -q xcompmgr

# ~/bin/core.sh

slstatus &
sxhkd &
xcompmgr &
