#!/bin/sh

monitor="VGA1"
main="LVDS1"

monitor_on() {
	xrandr --output $monitor --auto --left-of $main --primary
}
monitor_off() {
	xrandr --output $monitor --off
}

if [ "$1" = "on" ] ; then
	monitor_on
elif [ "$1" = "off" ] ; then
	monitor_off
elif [ -n "$(xrandr -q | grep "^${monitor} connected")" ] ; then
	monitor_on
else
	monitor_off
fi
