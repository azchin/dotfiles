#!/bin/sh
file=/usr/local/share/paccount
nu=$(cat $file)
echo $nu pkgs
tail -f $file | while read -r line
do
	echo "${line} pkgs"
done
# while inotifywait -q -e modify $file >/dev/null ; do
# 	nu=$(cat $file)
# 	echo $nu pkgs
# done
