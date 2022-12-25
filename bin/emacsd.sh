#!/bin/sh
killall -q emacs && emacs --daemon &
dolphin &
# [ $(ps ax | grep "emacs --daemon" | wc -l) -le 1 ] && emacs --daemon &
