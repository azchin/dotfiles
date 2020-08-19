#!/bin/sh

_bspdraw() {
	build=""
	for desk in $(echo $1 | sed -E "s/:L.*$//;s/^[^:]*://;s/:/ /g") ; do
		# state=${desk:0:1}
		# name=${desk:1}
		state=$(echo $desk | head -c1)
		name=$(echo $desk | tail -c+2)
		case "$state" in
			O|F) # focused occupied # focused unoccupied
				fg="#fba922"
				bg="#3d4247"
				ul="#fba922"
				;;
			o) # unfocused occupied
				fg="#a2a2a2"
				bg="#31363b"
				ul="#ff3daee9"
				;;
			U) # focused urgent
				fg="#f4005f"
				bg="#31363b"
				ul="#f4005f"
				;;
			u) # unfocused urgent
				fg="#f4005f"
				bg="#31363b"
				ul="#f4005f"
				;;
			f|*) # unfocused unoccupied
				fg="#a2a2a2"
				bg="-"
				ul="-"
		esac
		build="${build}%{U${ul}}%{B${bg}}%{F${fg}}%{A:${name}:} ${name} %{A}%{F-}%{B-}%{U-}"
	done
	echo "%{+u}${build}%{-u}"
}

_bspwm() {
	bspc subscribe report | while read -r line
	do
		_bspdraw $line
	done
}

_format() {
	$1 | while read -r line
	do
		echo "%{r}$line"
	done
}

_format _bspwm | lemonbar \
	-f "DejaVu Sans Mono:style=Bold:size=9" \
	-B "#ff0f0f0f" \
	-F "#ffe5e5e5" \
	-U "#ff0f0f0f" \
	-u 3 \
	-b -p \
	-g x27++ \
	| while read -r line 
do
	bspc desktop $line -f
done
