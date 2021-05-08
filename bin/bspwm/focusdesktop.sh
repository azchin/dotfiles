#!/bin/sh

#desktop=$1
#desktop=$(( ($1 + 9) % 10 ))
desktop=$(~/bin/bspwm/desktopname.sh $1)

bspc desktop -f "$desktop"
# [ $(bspc query -D -d) = $(bspc query -D -d "$desktop") ] && \
# 	bspc desktop -f last || \
# 	bspc desktop -f "$desktop"

