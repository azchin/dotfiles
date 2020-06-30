#!/bin/sh

. ~/.config/profile
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx

currentDesktop=$([ -n "$(pidof sxhkd)" ] && echo $(bspc query -D -d --names) || echo "1")

# special resets
redshift -x

# kill services
pkill sxhkd
pkill dunst 
pkill picom
#pkill xflux
pkill keepassxc
pkill redshift
#pkill imwheel
pkill onedrive
pkill xss-lock
pkill light-locker
pkill udiskie
tmux kill-server
killall -q fcitx
killall -q polybar
# ~/bin/lemonbar/kill-lemon.sh
setxkbmap -option

# services
#xset m 4/5 1
# xmodmap ~/.config/X11/Xmodmap
sxhkd &
dunst &
[ -z "$(pidof urxvtd)" ] && urxvtd &
[ -z "$(pidof xfce4-power-manager)" ] && xfce4-power-manager
#[ -n "$(xrandr -q | grep "60.00\*")" ] && xrandr --output HDMI-A-0 --mode 1920x1080 --rate 75
fcitx &
udiskie --tray &
#imwheel
xsetroot -cursor_name left_ptr
# find setxkbmap options in /usr/share/X11/xkb/rules/base.lst
setxkbmap -option caps:escape_shifted_capslock
# setxkbmap -option caps:swapescape
~/bin/wallpaper.sh
picom -b
xss-lock -l ~/bin/lock.sh & 
tmux new -s andrew -d 
onedrive -m &
# xss-lock --transfer-sleep-lock -- light-locker-command -l &
# light-locker &
# light-locker --lock-on-suspend --lock-after-screensaver=60 --idle-hint &
# light-locker --late-locking --lock-on-suspend --lock-after-screensaver=25 &
#~/bin/polybar/polybar-bsp.sh -r
~/bin/polybar/launch.sh &
# ~/bin/lemonbar/lemonbar.sh
nm-applet &
redshift &

# startup

#if [ $(bspc query -N -d "2" | wc -l) -eq 0 ] ; then
#	bspc rule -a brave -o desktop="2"
#	brave &
#fi

if [ $(bspc query -N -d "^2" | wc -l) -eq 0 ] ; then
	bspc rule -a firefox -o desktop="^2"
  firefox &
fi

if [ $(bspc query -N -d "^5" | wc -l) -eq 0 ] ; then
	bspc rule -a KeePassXC -o desktop="^5"
	keepassxc --keyfile ~/Desktop/Passwords.key ~/Desktop/Passwords.kdbx &
fi

# if [ $(bspc query -N -d "^1" | wc -l) -eq 0 ] ; then
# 	bspc rule -a Alacritty -o desktop="^1"
# 	alacritty --config-file ~/.config/alacritty/rice.yml &
# fi

if [ $(bspc query -N -d "^1" | wc -l) -eq 0 ] ; then
	bspc rule -a URxvt -o desktop="^1"
	urxvtc &
fi

bspc desktop -f $currentDesktop
sleep 2
#bspc node @5:/ -g hidden=on
