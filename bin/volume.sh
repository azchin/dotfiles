#!/bin/sh

opt=$1

if [ "$opt" = "mute" ] ; then
	~/bin/pulseaudio/mute.sh
	muted=$(~/bin/pulseaudio/status.sh)
	message=$([ "$muted" = "mute" ] && echo "Unmuted" || echo "Muted")
	# ~/bin/alsa/mute.sh
	# vol=$(~/bin/alsa/volume.sh)
	# message="Volume: ${vol}"
	icon=$([ $muted -eq 0 ] && echo "audio-volume-muted" || echo "audio-on")
else
	~/bin/pulseaudio/change.sh $opt
	vol=$(~/bin/pulseaudio/status.sh volume)
	message="Volume: ${vol}%"
	# ~/bin/alsa/change.sh "$opt"
	# vol=$(~/bin/alsa/volume.sh)
	# message="Volume: ${vol}"
	icon="audio-volume-high"
fi
[ -z "$message" ] && exit 1
~/bin/notify.sh "$message" "$icon"
