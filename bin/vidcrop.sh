#!/bin/sh
[ $# -ne 3 ] && \
	echo "Usage: $0 starttime endtime filename" >&2 && \
	echo "time format: hh:mm:ss" >&2 && \
	exit 1
starttime=$1
endtime=$2
filename=$3
name=${filename%.*}
ext=${filename##*.}
# echo $name $ext
ffmpeg -ss $starttime -i "$filename" -to $endtime -c copy "${name}-trim.${ext}"
