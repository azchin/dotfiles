#!/bin/sh

hidden=$(bspc query -N -n '.hidden.local')
unfoc=$(bspc query -N -n '.!focused.!ancestor_of.local')
full=$(bspc query -N -n $(bspc query -N -n).fullscreen)
if [ -z "$full" ]; then
  echo "$unfoc" | xargs -I _id -n 1 bspc node _id -g hidden=on
  bspc node -t fullscreen
else
  bspc node -t \~fullscreen
  echo "$hidden" | xargs -I _id -n 1 bspc node _id -g hidden=off
fi
