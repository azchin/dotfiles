#!/bin/sh

# case $1 in
# 	list)
# 		nmcli device wifi list
# 		;;
# 	connect)
# 		nmcli device wifi connect $2
# 		;;
# 	*)
# 		nmcli device wifi list
# esac

cachedir=${XDG_DATA_HOME:=$HOME/.local/share}
cachefile="$cachedir"/ssidlist

force=0
[ "$1" = "-f" ] && force=1

if [ $force -eq 1 ] ; then
	list=$(nmcli -g SSID device wifi list)
else
	list=$(cat $cachefile)
	nmcli -g SSID device wifi list > $cachefile &
fi
# ssid=$(echo "$list" | sed -En "/\S/p" | drofi)
ssid=$(echo "$list" | sed -En "/\S/p" | dmenu -p "SSID")
[ -z "$ssid" ] && exit 1
passwd=$(echo "" | dmenu -p "Password")
nmcli device wifi connect "$ssid" $([ -n "$passwd" ] && echo "password ${passwd}")
