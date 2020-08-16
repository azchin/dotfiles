#!/bin/sh
pkill -x ffmpeg
if [ $? -eq 0 ] ; then
	notify-send "Stopped recording"
	exit 0
fi
resolution=$(xrandr -q | awk '{/\*/print $1;}')
filename=$1
filename=${filename:="$(date +%+4Y-%m-%d_%H%M%S).mkv"}
file="/home/andrew/videos/capture/$filename"
notify-send "Started recording $filename"
ffmpeg -f x11grab -video_size $resolution -framerate 60 -i $DISPLAY -c:v libx264 -preset ultrafast $file
