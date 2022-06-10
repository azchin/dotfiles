#!/bin/sh
export DISPLAY=:0
export XAUTHORITY=/home/andrew/.Xauthority
/home/andrew/bin/notify.sh "Idle detection disabled" "battery"
killall -q xidlehook
