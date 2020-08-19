#!/bin/sh

hidden=$(bspc query -N -n '.hidden.local')
unfoc=$(bspc query -N -n '.!focused.!ancestor_of.local')
if [ -z "$hidden" ]; then
  echo "$unfoc" | xargs -I _id -n 1 bspc node _id -g hidden=on
  bspc desktop -l monocle
else
	bspc desktop -l tiled
  echo "$hidden" | xargs -I _id -n 1 bspc node _id -g hidden=off
fi
