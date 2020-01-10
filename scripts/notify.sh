#!/bin/sh
# use for continuously replacing notifications
# usage: notify.sh <message> [options]
content=$1
icon=$([ -n "$2" ] && echo -i "$2")
dump=~/scripts/temp/notify.txt
options="-t 2000 -r 35"
dunstify $options "$content" $icon
