#!/bin/sh

output=$(amixer -M get Master || amixer -M get Speaker)
if [ "$(echo "$output" | awk -F"[][]" 'END{print $4}')" = "on" ] ; then # For pulseaudio
# if [ "$(echo "$output" | awk -F"[][]" 'END{print $6}')" = "on" ] ; then # For jack
	echo "$output" | awk -F"[][]" 'END{print $2}'
else
	echo "mute"
fi

