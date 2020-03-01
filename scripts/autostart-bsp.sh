#!/bin/sh

currentDesktop=$([ -n "$(pgrep sxhkd)" ] && echo $(bspc query -D -d --names) || echo "2")

# kill services
#pkill sxhkd
#pkill dunst 
#pkill picom
pkill xflux
pkill keepassxc
#pkill onedrive
#pkill xss-lock
pkill light-locker
tmux kill-server
#killall -q polybar
setxkbmap -option

# services
#xset m 4/5 1
#sxhkd &
#dunst &
#[ -n "$(xrandr -q | grep "60.00\*")" ] && xrandr --output HDMI-A-0 --mode 1920x1080 --rate 75
xsetroot -cursor_name left_ptr
# find setxkbmap options in /usr/share/X11/xkb/rules/base.lst
setxkbmap -option caps:escape_shifted_capslock
~/scripts/setbg.sh
#picom -b
#xss-lock --transfer-sleep-lock ~/scripts/lock.sh & 
tmux new -s andrew -d 
#onedrive -m &
light-locker --lock-on-suspend --lock-after-screensaver=25 --idle-hint &
#light-locker --late-locking --lock-on-suspend --lock-after-screensaver=25 --idle-hint &

# polybar
#~/scripts/polybar-bsp.sh -r
#~/.config/polybar/launch.sh &
~/scripts/ricerez.sh
nm-applet &
#xflux -l 43.7 -g -79.4 -k 3200
#xflux -k 3200

# startup

#if [ $(bspc query -N -d "2" | wc -l) -eq 0 ] ; then
#	bspc rule -a brave desktop="2"
#	brave &
#fi

if [ $(bspc query -N -d "2" | wc -l) -eq 0 ] ; then
	bspc rule -a firefox desktop="2"
  firefox &
fi

#sleep 1
#
#if [ $(bspc query -N -d "^9" | wc -l) -eq 0 ] ; then
#	bspc rule -r firefox
#	bspc rule -a firefox desktop="^9"
#	firefox --new-window youtube.com &
#fi

if [ $(bspc query -N -d "5" | wc -l) -eq 0 ] ; then
	bspc rule -a KeePassXC desktop="5"
	keepassxc --keyfile ~/Desktop/Passwords.key ~/Desktop/Passwords.kdbx &
fi

if [ $(bspc query -N -d "1" | wc -l) -eq 0 ] ; then
	bspc rule -a st-256color desktop="1"
	st &
fi

sleep 1
bspc desktop -f $currentDesktop
#bspc node @5:/ -g hidden=on
bspc rule -r KeePassXC
bspc rule -r st-256color
#bspc rule -r brave
bspc rule -r firefox
