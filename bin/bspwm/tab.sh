#!/bin/sh

bspc subscribe node_state node_remove | \
while read -r func one two three four five ; do
	hidden=$(bspc query -N -n '.hidden.local')
	unfoc=$(bspc query -N -n '.!focused.!ancestor_of.local')
	case "$func" in
		node_remove)
		# one: monitor two: desktop three: node
		if [ -n "$unfoc" ] && [ -n "$hidden" ] ; then
		  echo "$hidden" | xargs -I _id -n 1 bspc node _id -g hidden=off
		fi
		# polybar-msg cmd show
		;;
		# desktop_layout)
		# if [ "$three" = "monocle" ] ; then
		#   echo "$unfoc" | xargs -I _id -n 1 bspc node _id -g hidden=on
		# elif [ -n "$hidden" ] ; then
		#   echo "$hidden" | xargs -I _id -n 1 bspc node _id -g hidden=off
		# fi
		# ;;
		node_state)
		# one: mon id, two: desk id, three: node id, four: fullscreen, five: on/off
		full=$(bspc query -N -d $two -n $three.fullscreen)
		# polybar-msg cmd show
		if [ -n "$full" ]; then
		  echo "$unfoc" | xargs -I _id -n 1 bspc node _id -g hidden=on
			# polybar-msg cmd hide
		elif [ -n "$hidden" ] ; then
		  echo "$hidden" | xargs -I _id -n 1 bspc node _id -g hidden=off
		fi
		;;
	esac
done
