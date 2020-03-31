#!/bin/bash

#if [[ "$#" -ne 2 ]] ; then
#	exit 1
#fi

op=$1
in=$2

case $op in
	focusnode)
		if [[ $(bspc query --names -d -D focused) -eq $in ]] ; then
			bspc desktop -f last
		else
			bspc desktop -f "^$in"
		fi
		;;
	resize)
		pix=20
		h=left; j=bottom; k=top; l=right
		declare -a dir=( -$pix 0 $pix 0 0 $pix 0 -$pix )
		declare -A name=( [$h]=0 [$j]=1 [$l]=2 [$k]=3 )
		index=${name[$in]}
		pair=$(( $index + 4 ))
		bspc node -z $in ${dir[$index]} ${dir[$pair]} && exit 0
		if [[ $(bspc query -n -N $(bspc query -n -N).tiled | wc -l) -ne 0 ]] ; then
			declare -a oppname=( $l $k $h $j ) 
			bspc node -z ${oppname[$index]} ${dir[$index]} ${dir[$pair]}
		fi
		;;
esac

exit $?
