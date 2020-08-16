#!/bin/sh
file="$XDG_CACHE_HOME/lastdesktop"
togo=$(~/bin/desktopname.sh $1)
current=$(wmctrl -d | awk '/\*/{print $1}')
if [ -z "$1" ] || [ "$togo" = "$current" ] ; then
	togo="$(cat $file)"
fi
echo "$current" > $file
wmctrl -s "$togo"
