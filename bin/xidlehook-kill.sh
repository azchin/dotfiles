#!/bin/sh
export DISPLAY=:0
export XAUTHORITY=/home/andrew/.Xauthority

# xrandr | grep "XWAYLAND" 2>&1 1>/dev/null && exit

/home/andrew/bin/notify.sh "Idle detection disabled" "battery"

if [ -n "$(pidof wayfire)" ] ; then
    killall -q swayidle
else
    xset s off -dpms
    killall -q xidlehook
fi
