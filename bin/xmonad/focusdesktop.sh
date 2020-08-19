#!/bin/sh
file="$XDG_CACHE_HOME/lastdesktop"
togo=$1
current=$(wmctrl -d | awk '/\*/{print $1}')
if [ "$togo" = "$current" ] ; then
	togo="$(cat $file)"
	echo "$current" > $file
fi
wmctrl -s "$togo"
