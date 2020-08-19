#!/bin/sh

percent=$(~/bin/alsa/volume.sh)
echo "Vol: ${percent}"
stdbuf -oL alsactl monitor default Master | while read -r line
do
	percent=$(~/bin/alsa/volume.sh)
	echo "Vol: ${percent}"
done
