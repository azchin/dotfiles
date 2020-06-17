#!/bin/sh

opt=$1

if [ "$opt" = "mute" ] ; then
	# pulsemixer --toggle-mute
	# pulseaudio-ctl mute
	# muted=$(pulsemixer --get-mute)
	# message=$([ $muted -eq 0 ] && echo "Unmuted" || echo "Muted")
	# muted=$(pulseaudio-ctl full-status | cut -d' ' -f2)
	~/bin/pulseaudio/mute.sh
	muted=$(~/bin/pulseaudio/status.sh mute)
	message=$([ "$muted" = "no" ] && echo "Unmuted" || echo "Muted")
	icon=$([ $muted -eq 0 ] && echo "audio-volume-muted" || echo "audio-on")
else
	# pulsemixer --change-volume $opt
	# vol=$(pulsemixer --get-volume | cut -d' ' -f1)
	# message="Volume: ${vol}%"	
	# [ $opt -lt 0 ] && pulseaudio-ctl down $opt || pulseaudio-ctl up $opt
	# vol=$(pulseaudio-ctl current)
	~/bin/pulseaudio/change.sh $opt
	vol=$(~/bin/pulseaudio/status.sh volume)
	message="Volume: ${vol}%"
	icon="audio-volume-high"
fi
[ -z "$message" ] && exit 1
~/bin/notify.sh "$message" "$icon"
