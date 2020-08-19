#!/bin/sh

# pactl set-sink-mute @DEFAULT_SINK@ toggle

SINK=$(pacmd list-sinks|awk '/\* index:/{ print $3 }')
NEW_MUTE=toggle
if [[ $2 == 'no' || $2 == 'yes' || $2 == 'toggle' ]]; then
	NEW_MUTE="$2"
fi
pactl set-sink-mute "$SINK" "$NEW_MUTE"
# SOURCE_MUTED=$(pacmd list-sources|grep -A 15 '* index'|awk '/muted:/{ print $2 }')
