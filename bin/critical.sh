#!/bin/sh
[ $(cat /sys/class/power_supply/AC/online) -eq 0 ] && [ $(cat /sys/class/power_supply/BAT0/capacity) -le 8 ] && loginctl suspend
