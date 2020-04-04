#!/bin/sh

hidden=$(bspc query -N -d | xargs -I _id bspc query -N -n _id.hidden)
marked=$(bspc query -N -d | xargs -I _id bspc query -N -n _id.marked)
if [ -z "$hidden" ] ; then
	if [ -z "$marked" ] ; then
		bspc node -g hidden=on
	else
		echo "$marked" | xargs -I _id -n 1 bspc node _id -g hidden=on
		echo "$marked" | xargs -I _id -n 1 bspc node _id -g marked=off
	fi
else
	echo "$hidden" | xargs -I _id -n 1 bspc node _id -g hidden=off
fi
