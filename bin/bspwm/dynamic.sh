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

### Send to master
# Swap? master and selected (or newest focused)
# OR 
# create receptacle below @/1
# send selected to receptacle 1
# circulate @/1
# create receptacle at @/2/1
# send bottom of @/1 to receptacle 2
# OR (efficient? what about tree struct)
_send_to_master() {
	node_id=$(bspc query -N -n)
	if [ -n "$(bspc query -N @/1 -n "${node_id}.descendant_of.window")" ] ; then
		# how to account for multiple masters? bspc -h off
		node_id=$(bspc query -N -n 'last.local' || bspc query -N @/2 -n '.descendant_of.window' | head -n1)
	fi
	if [ $(bspc query -N @/ -n '.local.window' | wc -l) -le 2 ] ; then
		bspc node @/2 -s @/1
	else
		bspc node @/1 -p north
		bspc node $node_id -n @/1
		bspc node @/2 -p north
		bspc node $(bspc query -N @/1 -n '.descendant_of.window' | tail -n1) -n @/2
		bspc node @/1 -B
		bspc node @/2 -B
	fi
}

_focus_master() {
	node_id=$(bspc query -N @/1 -n '.descendant_of.window' | head -n1)
	if [ -n "$(bspc query -N @/1 -n 'focused.descendant_of')" ] ; then	
		node_id=$(bspc query -N -n 'last.local' || bspc query -N @/2 -n '.descendant_of.window' | head -n1)
	fi
	bspc node $node_id -f
}

_focus_down() {
	bspc node south -f
	if [ $? -ne 0 ] ; then
		if [ -n "$(bspc query -N @/1 -n 'focused.descendant_of')" ] ; then
			node_id=$(bspc query -N @/2 -n '.descendant_of.window' | head -n1)
		else
			node_id=$(bspc query -N @/1 -n '.descendant_of.window' | head -n1)
		fi
	fi
	bspc node $node_id -f
}

_focus_up() {
	bspc node north -f
	if [ $? -ne 0 ] ; then
		if [ -n "$(bspc query -N @/1 -n 'focused.descendant_of')" ] ; then
			node_id=$(bspc query -N @/2 -n '.descendant_of.window' | tail -n1)
		else
			node_id=$(bspc query -N @/1 -n '.descendant_of.window' | tail -n1)
		fi
	fi
	bspc node $node_id -f
}

### TODO
# account for multiple receptacles (find newest)
