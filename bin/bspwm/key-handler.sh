#!/bin/sh

# TODO make a layout handler, currently just two layouts
mod=$1
key=$2
# dynadesk=6
foc=$(bspc query -D -d --names)
if [ "$dynadesk" = "$foc" ] ; then
	case $key in
		h)
			[ "$mod" = "S" ] && opt="send" || opt="focus"
			~/bin/bspwm/dynamic-keys.sh $opt
			;;
		j)
			~/bin/bspwm/dynamic-keys.sh down
			;;
		k)
			~/bin/bspwm/dynamic-keys.sh up
			;;
		l)
			bspc node -f east
			;;
	esac
else # default bsp
	[ "$mod" = "S" ] && flag="s" || flag="f"
	case $key in
		h)
			bspc node -"$flag" west
			;;
		j)
			bspc node -"$flag" south
			;;
		k)
			bspc node -"$flag" north
			;;
		l)
			bspc node -"$flag" east
			;;
	esac
fi
