#!/bin/sh

amixer set Master on

PERC=$1
if [ $PERC -ge 0 ] ; then
	PERC=${PERC#\+}
	amixer -q -M set Master "${PERC}%+" || \
	amixer -q -M set Speaker "${PERC}%+"
else
	PERC=$((- $PERC))
	amixer -q -M set Master "${PERC}%-" || \
	amixer -q -M set Speaker "${PERC}%-"
fi

# [ $? -ne 0 ] && ~/bin/asound.sh
