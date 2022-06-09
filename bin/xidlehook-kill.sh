#!/bin/sh
export DISPLAY=:0
export XAUTHORITY=/home/andrew/.Xauthority
/home/andrew/bin/notify.sh "Idle detection disabled" "battery-100"
killall -q xidlehook
