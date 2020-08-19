#!/bin/sh
file=/usr/local/share/paccount
cat $file
while inotifywait -q -e modify $file >/dev/null ; do
	cat $file
done
