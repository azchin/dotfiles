#!/bin/sh

opt=$1

_rquery() { 
	bspc query -N -n '.local.!window.leaf' 
}

_kill() {
	id=$(_rquery | head -n1)
	[ -n "$id" ] && bspc node $id -k
}

_killall() {
	_rquery | xargs -I _id -n 1 bspc node _id -k
}

_swap() {
	id=$(_rquery | tail -n1)
	[ -n "$id" ] && bspc node -s $id
}

_spawn() {
	dir=$1
	if [ -z "$(_rquery)" ] ; then
		[ -n "$dir" ] && bspc node -p "$dir"
		bspc node -i
	else
		_kill
		[ -n "$dir" ] && bspc node -p "$dir"
		bspc node -i
	fi
}

case $opt in
	kill)
		_kill ;;
	killall)
		_killall ;;
	swap)
		_swap ;;
	spawn)
		_spawn $2 ;;
esac



#bspc query -N "any.local.\!window.leaf" -n
#bspc node -i
#bspc node _id -k
#bspc node -n _id
#bspc node -s _id
#bspc node -g hidden=on/off (or hidden for togge)
#bspc subscribe node_add
#bspc rule -a * hidden=on
