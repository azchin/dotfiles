#!/bin/sh

currentDesktop=$([ -n "$(pgrep sxhkd)" ] && echo $(bspc query -D -d --names) || echo "2")

# kill services
pkill sxhkd
pkill picom
pkill xflux
pkill flameshot
pkill keepassxc
tmux kill-server
killall -q polybar
setxkbmap -option

# services
#xset m 4/5 1
sxhkd &
#[ -n "$(xrandr -q | grep "60.00\*")" ] && xrandr --output HDMI-A-0 --mode 1920x1080 --rate 75
xsetroot -cursor_name left_ptr
# find setxkbmap options in /usr/share/X11/xkb/rules/base.lst
setxkbmap -option caps:escape_shifted_capslock
~/scripts/setbg.sh
picom -b
xss-lock --transfer-sleep-lock ~/scripts/lock.sh & 
tmux new -s andrew -d 

# polybar
~/scripts/polybar-bsp.sh -r
~/.config/polybar/launch.sh &
nm-applet &
flameshot &
xflux -l 43.7 -g -79.4 -k 4000

# startup

if [ $(bspc query -N -d "^2" | wc -l) -eq 0 ] ; then
	bspc rule -a firefox desktop="^2"
	firefox &
fi

#sleep 1
#
#if [ $(bspc query -N -d "^9" | wc -l) -eq 0 ] ; then
#	bspc rule -r firefox
#	bspc rule -a firefox desktop="^9"
#	firefox --new-window youtube.com &
#fi

if [ $(bspc query -N -d "^4" | wc -l) -eq 0 ] ; then
	bspc rule -a KeePassXC desktop="^4"
	keepassxc --keyfile ~/Desktop/Passwords.key ~/Desktop/Passwords.kdbx &
fi

if [ $(bspc query -N -d "^1" | wc -l) -eq 0 ] ; then
	bspc rule -a st-256color desktop="^1"
	st &
fi

sleep 1
bspc desktop -f $currentDesktop
bspc rule -r KeePassXC
bspc rule -r st-256color
bspc rule -r firefox
