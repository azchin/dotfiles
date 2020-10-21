#!/bin/sh

output=$(amixer -M get Master || amixer -M get Speaker)
if [ "$(echo "$output" | awk -F"[][]" 'END{print $4}')" = "on" ] ; then
	echo "$output" | awk -F"[][]" 'END{print $2}'
else
	echo "mute"
fi

