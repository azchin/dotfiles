#!/bin/sh

opt=$1

if [ "$opt" = "mute" ] ; then
	pulsemixer --toggle-mute
	muted=$(pulsemixer --get-mute)
	message=$([ $muted -eq 0 ] && echo "Unmuted" || echo "Muted")
	icon=$([ $muted -eq 0 ] && echo "audio-volume-muted" || echo "audio-on")
else
	pulsemixer --change-volume $opt
	vol=$(pulsemixer --get-volume | cut -d' ' -f1)
	message="Volume: ${vol}%"	
	icon="audio-volume-high"
fi
[ -z "$message" ] && exit 1
~/scripts/notify.sh "$message" "$icon"
