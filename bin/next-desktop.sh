#!/bin/sh
inc=1
if [ "$1" = "previous" ] ; then
    inc=-1
fi
desktops=$(wmctrl -d)
total=$(echo "$desktops" | wc -l)
current=$(echo "$desktops" | grep '*' | cut -d' ' -f1)
next=$(( ($current + $inc + $total) % $total ))
echo $next
wmctrl -s $next
