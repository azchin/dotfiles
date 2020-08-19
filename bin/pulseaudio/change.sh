#!/bin/sh

# Usage: $0 (-|+)percent
# pactl set-sink-volume @DEFAULT_SINK@ {-,+}1%

UPPER_THRESHOLD=100
CURVOL=$(pacmd list-sinks|grep -A 15 '* index'| awk '/volume: front/{ print $5 }' | sed 's/[%|,]//g')
SINK=$(pacmd list-sinks|awk '/\* index:/{ print $3 }')

PERC=$1
if [ $PERC -ge 0 ] ; then
	PERC=${PERC#\+}
	[ "$(( $PERC + $CURVOL ))" -gt "$UPPER_THRESHOLD" ] && \
		PERC="$(( $UPPER_THRESHOLD - $CURVOL ))"
	[ "$CURVOL" -ge $UPPER_THRESHOLD ] && \
		pactl set-sink-volume "$SINK" $UPPER_THRESHOLD% ||
		pactl set-sink-volume "$SINK" +$PERC%
else
	PERC=$((- $PERC))
	[ "$PERC" -gt "$CURVOL" ] && PERC="$CURVOL"
	[ "$CURVOL" -le 0 ] && \
		exit 0 || \
		pactl set-sink-volume "$SINK" -$PERC%
fi
