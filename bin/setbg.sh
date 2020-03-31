#!/bin/sh

reset=0
if [ "$1" = "-r" ] ; then
	reset=1
fi

bgdir=~/images/desktopbg2
store=~/scripts/temp/setbg.txt
files=$(ls $bgdir)
num=$(echo "$files" | wc -w)
[ $reset -eq 1 ] && echo 1 > $store
index=$(cat $store)
#hsetroot -cover "${bgdir}/$(echo "$files" | sed "${index}q;d")"
habak -mS "${bgdir}/$(echo "$files" | sed "${index}q;d")"
echo $(( ( index % num ) + 1 )) > $store 
