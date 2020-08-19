#!/bin/sh

output=$(amixer get Master)
if [ "$(echo "$output" | awk -F"[][]" '/Left:/{print $4}')" = "on" ] ; then
	echo "$output" | awk -F"[][]" '/Left:/{print $2}'
else
	echo "mute"
fi

