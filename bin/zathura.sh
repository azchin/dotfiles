#!/bin/sh
pdir=$XDG_CACHE_HOME/zathura
pid=$(cat $pdir)
file=$1 # currently only supports one file param
if [ $(ps -ef | grep -o "tabbed -c zathura" | wc -l) -gt 1 ] ; then
  zathura -e "$pid" "$file" &
else
  tabbed -c zathura "$file" -e > $pdir &
fi
