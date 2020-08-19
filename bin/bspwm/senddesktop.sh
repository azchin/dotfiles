#!/bin/sh

marked=$(bspc query -N -n '.marked.local')
desktop=$(~/bin/bspwm/desktopname.sh $1)
if [ -n "$marked" ] ; then
	echo "$marked" | xargs -I _id bspc node _id -d $desktop
	echo "$marked" | xargs -I _id bspc node _id -g marked=off
else
	bspc node -d $desktop
fi
