#!/bin/sh

desktop=$1

[ $(bspc query -D -d) = $(bspc query -D -d "$desktop") ] && \
	bspc desktop -f last || \
	bspc desktop -f "$desktop"

