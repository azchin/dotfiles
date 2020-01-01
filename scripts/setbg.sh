#!/bin/sh

reset=0
if [ $1 = "-r" ] ; then
	reset=1
fi

bgdir=~/images/desktopbg1
store=~/scripts/temp/setbg.txt
num=$(ls $bgdir | wc -w)
[ $reset -eq 1 ] && echo 1 > $store
index=$(cat $store)
hsetroot -cover "${bgdir}/$(ls ${bgdir} | sed "${index}q;d")"
echo $(( ( index % num ) + 1 )) > $store 
