#!/bin/sh
unfocused=$(bspc query -N -n '.!focused.local.leaf')
hidden=$(bspc query -N -n '.hidden.local')

if [ -n "$hidden" ]; then
    bspc node -t floating
    echo "$hidden" | xargs -I _id -n 1 bspc node _id -g hidden=off
    echo "$unfocused" | xargs -I _id -n 1 bspc node _id -t floating
else
    echo "$unfocused" | xargs -I _id -n 1 bspc node _id -g hidden=on
    bspc node -t tiled
fi    
