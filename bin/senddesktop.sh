#!/bin/sh
desktop=$(~/bin/desktopname.sh $1)
wmctrl -r :ACTIVE: -t $desktop
