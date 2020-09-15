#!/bin/sh

amixer set Master on

PERC=$1
if [ $PERC -ge 0 ] ; then
	PERC=${PERC#\+}
	amixer --quiet set Master "${PERC}%+" || \
	amixer --quiet set Speaker "${PERC}%+"
else
	PERC=$((- $PERC))
	amixer --quiet set Master "${PERC}%-" || \
	amixer --quiet set Speaker "${PERC}%-"
fi

# [ $? -ne 0 ] && ~/bin/asound.sh
