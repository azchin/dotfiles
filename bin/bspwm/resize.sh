#!/bin/sh

dir=$1
pix=20

_resize() {
  bspc node -z $dir $dx $dy
}


case $dir in
  left) 
  dx=-$pix  ; dy=0      ; opp=right   ;;
  bottom) 
  dx=0      ; dy=-$pix  ; opp=top     ;;
  top)
  dx=0      ; dy=$pix   ; opp=bottom  ;;
  right)
  dx=$pix   ; dy=0      ; opp=left    ;;
  *) exit 1 ;;
esac

_resize && exit 0
dir=$opp
[ -n "$(bspc query -N -n focused.tiled)" ] && _resize
