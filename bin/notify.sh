#!/bin/sh
# use for continuously replacing notifications
# usage: notify.sh <message> [icon]

content=$1
icon=$([ -n "$2" ] && echo -i "$2")
options="-t 2000 -r 69"
# dunstify $options "$content" $icon
notify-send -i "$icon" "$content" 
