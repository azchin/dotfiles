#!/bin/sh
histfile=~/.surf/history.txt
histsize=1000
windowid=$1
#sort -u -o $histfile $histfile
tail -n$histsize $histfile | sponge $histfile
uri=$(tac $histfile | tail -n+2 | dmenu -l 5 -b -i -p "" -w $windowid)
if [ -n "$(echo "$uri" | grep -E "^https://")" ]; then 
  echo "$uri" | cut -d ' ' -f 1
else
  echo "$uri"
fi
awk '{a[i++]=$0} END {for (j=i-1; j>=0; --j) if(!seen[a[j]]++) b[k++]=a[j]} END {for(j=k-1; j>=0;) print b[j--]}' $histfile | sponge $histfile
