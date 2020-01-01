#!/bin/sh

config=~/.config/polybar/config
#config=~/.config/polybar/config
dump=~/scripts/temp/polybar-bsp.txt

restart=0
[ "$1" = "-r" ] && restart=1

if [ $restart -eq 1 ] ; then
	init=$(grep -En "^ws-icon-[0-9]+" $config | head -n1 | cut -d: -f1)
	sed -Ei "/^ws-icon-[0-9]+/d" "$config" 
	while read line ; do
		sed -i "${init}i${line}" $config
		init=$((init + 1))
	done < $dump
	exit 0
fi

desktops="$(bspc query -D --names)"

# removes unused entries in config
current=$(grep -En "^ws-icon-[0-9]+" $config)
echo "$current" | sed -E "s/.*ws-icon.*= //g;s/\;.*//g" | while read -r name ; do
	if [ -z "$(echo $desktops | grep -o $name)" ] ; then
		sed -i "/= $name\;/d" $config
	fi
done

# re-index current entries
current=$(grep -En "^ws-icon-[0-9]+" $config)
index=0
echo "$current" | sed -E "s/^.*://" | while read -r line ; do
	newline=$(echo $line | sed -E "s/[0-9]+/${index}/")
	sed -i "s/${line}/${newline}/" $config
	index=$((index + 1))
done

# insert new desktop names
current=$(grep -En "^ws-icon-[0-9]+" $config)
index=$(echo "$current" | sed '$!d;s/.*icon-//;s/ =.*//')
line=$(echo "$current" | tail -n1 | cut -d: -f1)

for name in $desktops ; do
	new=$(echo "$current" | sed "s/.*ws-icon-.* = //" | grep -o $name)
	[ ! -z "$new" ] && continue
	sed -i "$((line + 1))iws-icon-$((index + 1)) = ${name};%{T3}${name}%{T-}" $config
	line=$((line + 1))
	index=$((index + 1))
done

killall -q polybar
~/.config/polybar/launch-bsp.sh &
