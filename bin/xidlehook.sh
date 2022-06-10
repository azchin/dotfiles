#!/bin/sh
export DISPLAY=:0
export XAUTHORITY=/home/andrew/.Xauthority
/home/andrew/bin/notify.sh "Idle detection enabled" "battery"
[ -z "$(pidof xidlehook)" ] && \
    xidlehook \
    --detect-sleep \
    --not-when-fullscreen \
    --not-when-audio \
    --timer 180 'xrandr --output eDP1 --brightness 0.25' 'xrandr --output eDP1 --brightness 1' \
    --timer 600 'systemctl suspend-then-hibernate' 'xrandr --output eDP1 --brightness 1'
