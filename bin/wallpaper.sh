#!/bin/sh

hsetroot -cover "$HOME/Pictures/zQbYocwXGY.png"
exit

store=${XDG_DATA_HOME:=$HOME/.local/share}/wallpaper
reset=0
if [ "$1" = "-r" ] || ! [ -f "$store" ]; then
	reset=1
fi

bgdir=~/images/desktopbg
files=$(ls $bgdir)
num=$(echo "$files" | wc -w)
[ $reset -eq 1 ] && echo 1 > $store
index=$(cat $store)
hsetroot -cover "${bgdir}/$(echo "$files" | sed "${index}q;d")"
#habak -mS "${bgdir}/$(echo "$files" | sed "${index}q;d")"
echo $(( ( index % num ) + 1 )) > $store 
