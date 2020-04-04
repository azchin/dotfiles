#!/bin/sh

hidden=$(bspc query -N -d | xargs -I _id bspc query -N -n _id.hidden)
full=$(bspc query -N -n $(bspc query -N -n).fullscreen)
unfoc=$(bspc query -N -d | xargs -I _id bspc query -N -n _id.\!focused.\!ancestor_of)
if [ -z "$full" ]; then
  echo "$unfoc" | xargs -I _id -n 1 bspc node _id -g hidden=on
  bspc node -t \~fullscreen
else
  bspc node -t \~fullscreen
  echo "$hidden" | xargs -I _id -n 1 bspc node _id -g hidden=off
fi
