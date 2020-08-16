#!/bin/sh
file="$XDG_CACHE_HOME/lastdesktop"
current=$(wmctrl -d | awk '/\*/{print $1}')
if [ "$1" = "prev" ] ; then
	togo=$(( $current - 1 ))
else
	togo=$(( $current + 1 ))
fi
echo "$current" > $file
wmctrl -s "$togo"
