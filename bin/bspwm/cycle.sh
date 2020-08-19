#!/bin/sh


hidden=$(bspc query -N -n '.hidden.local')
# unfoc=$(bspc query -N -n '.!focused.!ancestor_of.local')
if [ -n "$hidden" ] ; then
	old=$(bspc query -N -n)
	echo "$hidden" | xargs -I _id -n 1 bspc node _id -g hidden=off
fi

bspc node -f "$1".local

foc=$(bspc query -N -n)
if [ -n "$hidden" ] ; then
	hidden=$(echo "$hidden" | sed "s/${foc}/${old}/")
	echo "$hidden" | xargs -I _id -n 1 bspc node _id -g hidden=on
fi
