#!/bin/sh

amixer set Master on

PERC=$1
if [ $PERC -ge 0 ] ; then
	PERC=${PERC#\+}
	amixer --quiet set Master "${PERC}%+"
else
	PERC=$((- $PERC))
	amixer --quiet set Master "${PERC}%-"
fi
