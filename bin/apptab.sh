#!/bin/sh

cur_id=$(xprop -root _NET_ACTIVE_WINDOW | sed 's/^.*# //')
win_class=$(xprop -id $cur_id WM_CLASS | sed 's/^.*= "\(.*\)",.*$/\1/')

# get list of all windows matching with the class above
win_list=$(wmctrl -x -l | grep "$win_class\." | cut -d' ' -f1)

# get next window to focus on, removing id active
cur_id=${cur_id#0x}
switch_to=$(echo "$win_list" | awk "f{print;f=0} /$cur_id/{f=1}")

# if the current window is the last in the list ... take the first one
if [ "$switch_to" = "" ]; then
   switch_to=$(echo "$win_list" | head -n1)
fi

# switch to window
wmctrl -i -a $switch_to
