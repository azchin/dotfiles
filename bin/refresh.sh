#!/bin/sh

refresh=$([ -n "$(xrandr -q | grep "60\.00\*")" ] && echo 75 || echo 60)
xrandr --output HDMI-A-0 --mode 1920x1080 --rate $refresh
