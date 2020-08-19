#!/bin/sh

### Nice features:
# Timed presel + turn off visual feedback
# Dynamic desktop responds to both spawn and sent nodes
# Dynamic desktop handles node sends and removals similarly
# Push nodes down stack
# Manage sends + spawns with bspc subscribe node_add node_transfer

### "Bottom" of tree
# could rely on print order of -N @/2 -n '.descendant_of.leaf'

### Single master
# create new split at @/2
# swap new split with master @/1
# balance @/2

### Removing single master
# seems fine by default

### Removing multiple master
# from slaves: seems fine
# from master: 
# 

### Focus down / up
# focus down ; if fails then focus @/1 or @/2

### Double/multiple master
# create new split at bottom of @/2
# balance
# circulate
# Case: 1 window in master
# presel bottom of @/ && send node to @/
# Case: 1 < masters < limit
# presel bottom of @/1 && send node to @/1
# swap bottom of @/1 and @/2
# Case: masters = limit
# presel bottom of @/1 && send node to @/1
# swap bottom of @/1 and @/2
# perform SLAVEROTATE

### Increasing number of masters from single
# create receptacle below @/1
# send @/2/1 to receptacle

### Increasing number of master from multiple
# presel bottom of @/1 to go down
# send top of @/2 to bottom of @/1
# bspc node $(bspc query -N @/1 -n '.descendant_of.window' | tail -n1) -p south
# bspc node @/2 -n $(bspc query -N @/2 -n '.descendant_of.window' | head -n1) -n \
#		$(bspc query -N @/1 -n '.descendant_of.window' | tail -n1)
# bspc node @/1 -B
# bspc node @/2 -B

### Decreasing number of master
# presel top of @/2
# send bottom of @/1 to @/2

### When all master, or all slaves
# Counting number of windows in master / slave
# bspc query -N @/1 -n '.descendant_of.window' | wc -l
# 	only works for non empty sets, store the value in cache
# All slaves: 1 master -> 0
# bspc node @/ -R 90
# bspc node @/2 -R -90
# bspc node @/ -B
# All slaves: 0 master -> 1
# bspc node @/2 -R 90
# bspc node @/ -R -90
# bspc node @/ -r 0.5
# All master: 1 slaves -> 0 (@/2 contains 1)
# bspc node @/ -R 90
# bspc node @/1 -R -90
# bspc node @/ -B
# SLAVEROTATE
# All master: 0 slaves -> 1 (@/2 contains 1)
# bspc node @/1 -R 90
# bspc node @/ -R -90
# bspc node @/ -r 0.5

# _readjust() {
# 	mastermax=1 # TODO hardcoded, change to read from cache
# 	masters=$(bspc query -N @/1 -n '.descendant_of.window')
# 	slaves=$(bspc query -N @/2 -n '.descendant_of.window')
# 	mastercount=$(bspc query -N @/1 -n '.descendant_of.window' | wc -l)
# 	slavecount=$(bspc query -N @/2 -n '.descendant_of.window' | wc -l)
# 	bottom=$(bspc query -N @/1 -n '.descendant_of.window' | tail -n1)
# 	top=$(bspc query -N @/2 -n '.descendant_of.window' | head -n1)
# 	if [ $mastercount -gt $mastermax ] ; then
# 		bspc node $top -p north
# 		bspc node $bottom -n $top
# 		# TODO 0 master cond
# 	# elif [ $mastercount -lt $mastermax ] && [ $slavecount -gt 0 ] ; then
# 	# 	TODO 0 slave cond
# 	fi
# }

dynadesk=6
deskid=$(bspc query -D -d "$dynadesk")

_remove() {
	bmaster=$(bspc query -N @/1 -n '.descendant_of.window' | tail -n1)
	bslave=$(bspc query -N @/2 -n '.descendant_of.window' | tail -n1)
	if [ -n "$(bspc query -N $bmaster -n south)" ] ; then
		# reformat the ENTIRE tree sometimes
		bspc node @/ -R 270
		bspc node @/2 -R 90
		bspc node @/ -r 0.5
	fi
	# bspc node @/1 -B
	# bspc node @/2 -B
}


# _spawn() {
# 	node_id=$1
# 	bspc node "$node_id" -g hidden=on
# 	dest=$(bspc query -N @/1 -n '.!hidden.descendant_of.window' | head -n1)
# 	if [ -n "$dest" ] ; then
# 		bspc node "$dest" -p west
# 		bspc node "$dest" -f
# 		bspc node "$node_id" -n "$dest"
# 	fi
# 	bspc node "$node_id" -g hidden=off
# 	bspc node "$node_id" -f
# 	# Readjust
# 	masters=$(bspc query -N @/1 -n '.descendant_of.window') 
# 	mastercount=$(echo "$masters" | wc -l)
# 	bmaster=$(bspc query -N @/1 -n '.descendant_of.window' | tail -n1)
# 	bslave=$(bspc query -N @/2 -n '.descendant_of.window' | tail -n1)
# 	if [ $mastercount -gt 1 ] ; then
# 		bspc node $bslave -p south
# 		bspc node $bmaster -n $bslave
# 		bspc node @/2 -C forward
# 		# TODO 0 master cond
# 	# elif [ $mastercount -lt $mastermax ] && [ $slavecount -gt 0 ] ; then
# 	# 	TODO 0 slave cond
# 	fi
# 	bspc node @/1 -B
# 	bspc node @/2 -B
# }

_spawn() {
	mastercount=$(echo "$masters" | wc -l)
	bmaster=$(bspc query -N @/1 -n '.descendant_of.window' | tail -n1)
	tslave=$(bspc query -N @/2 -n '.descendant_of.window' | head -n1)
	if [ $mastercount -gt 1 ] ; then
		bspc node $bmaster -s $tslave
	fi
	bspc node @/1 -B
	bspc node @/2 -B
}

bspc subscribe node_add node_remove node_transfer desktop_focus \
	| while read -r event a b c d e
do
	if [ "$deskid" = "$b" ] ; then
		bspc config removal_adjustment false
		case $event in
			node_add)
				_spawn "$d"
				;;
			node_remove)
				_remove
				;;
			node_transfer) # have to make sure it's monitor transfer
				! [ "$b" = "$d" ] && ([ "$b" = "$deskid" ] && _remove || _spawn)
				;;
		esac
	else
		bspc config removal_adjustment true
	fi
done
