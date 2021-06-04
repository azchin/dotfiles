#!/bin/sh

currentDesktop=$([ -n "$(pidof sxhkd)" ] && echo $(bspc query -D -d --names) || echo "1")

pkill sxhkd
pkill xcompmgr
pkill tint2
pkill alttab
# ~/bin/lemonbar/kill-lemon.sh
# killall -q polybar
# pkill tab.sh

~/bin/core.sh

#~/bin/polybar/polybar-bsp.sh -r
# [ -z "$(pidof)" ] && (~/bin/polybar/launch.sh &) || polybar-msg cmd restart
# ~/bin/lemonbar/lemonbar.sh
# ~/bin/bspwm/tab.sh &
sxhkd ~/.config/sxhkd/bspwm-float-sxhkdrc &
xcompmgr &
tint2 &
alttab -fg "#d58681" -bg "#31363b" -frame "#eb564d" -t 128x150 -i 127x64 &

# startup

#if [ $(bspc query -N -d "2" | wc -l) -eq 0 ] ; then
#	bspc rule -a brave -o desktop="2"
#	brave &
#fi

# if [ $(bspc query -N -d "^1" | wc -l) -eq 0 ] ; then
# 	bspc rule -a firefox -o desktop="^1"
#   firefox &
# fi

# if [ $(bspc query -N -d "^5" | wc -l) -eq 0 ] ; then
# 	bspc rule -a KeePassXC -o desktop="^5"
# 	keepassxc --keyfile ~/Desktop/Passwords.key ~/Desktop/Passwords.kdbx &
# fi

# if [ $(bspc query -N -d "^1" | wc -l) -eq 0 ] ; then
# 	bspc rule -a Alacritty -o desktop="^1"
# 	alacritty --config-file ~/.config/alacritty/rice.yml &
# fi

# if [ $(bspc query -N -d "^2" | wc -l) -eq 0 ] ; then
# 	bspc rule -a URxvt -o desktop="^2"
# 	urxvtc &
# fi

bspc desktop -f $currentDesktop
sleep 2
#bspc node @5:/ -g hidden=on
