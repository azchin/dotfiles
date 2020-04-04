#!/bin/sh

default="<<"
name=$(echo "$default\n$(bspc query -D --names)" | dmenu -p "Remove desktop")
[ "$name" = "$default" ] && name=$(bspc query -D --names | tail -n1)
[ -z "$name" ] && exit 1
bspc desktop $name -r
