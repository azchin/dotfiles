#!/bin/sh

opt=$1

case $opt in
prev)
	msg=$(mpc prev 2>&1 | head -n1) 
	icon="media-skip-backward"
	;;
play)
	msg=$(mpc toggle 2>&1)
	state=$(echo "$msg" | tail -n+2 | grep -Eo "(playing|paused)") 
	icon=$([ "$state" = "playing" ] && echo "media-playback-start" || echo "media-playback-pause")
	msg=$(echo "$msg" | head -n1)
	;;
next)
	msg=$(mpc next 2>&1 | head -n1) 
	icon="media-skip-forward"
	if [ $(echo $msg | wc -l) -eq 1 ] ; then
		[ -n "$(echo $msg | grep -E "^MPD error")" ] && msg="End of playlist"
		icon="media-playback-stop"
	fi
	;;
esac

[ -z "$msg" ] || [ -n "$(echo "$msg" | grep -E "^MPD")" ] && exit 1	
~/bin/notify.sh "$msg" "$icon"
