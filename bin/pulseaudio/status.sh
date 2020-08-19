#!/bin/sh

case $1 in
	volume)
		pacmd list-sinks|grep -A 15 '* index'| awk '/volume: front/{ print $5 }' | sed 's/[%|,]//g'
		;;
	mute)
		pacmd list-sinks|grep -A 15 '* index'|awk '/muted:/{ print $2 }'
		;;
	*)
		echo "Unavailable option"
esac
