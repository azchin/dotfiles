#!/bin/sh

default=">>"
name=$(echo "$default" | dmenu -p "Enter new desktop name")
[ "$name" = "$default" ] && name=$(( $(bspc query -D --names | grep -E "[0-9]+" | sort -nr | head -n1) + 1))
while [ $(bspc query -D --names | grep $name | wc -l) -gt 0 ] ; do
	name=$(echo "$default" | dmenu -p "Desktop already exists - use unique name")
done
[ -z "$name" ] && exit 1
bspc monitor -a $name
~/bin/polybar/polybar-bsp.sh
