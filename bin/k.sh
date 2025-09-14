#!/bin/sh
set -eu
arg=${1:-q}

case $arg in
    q)
        setxkbmap -layout us
        ;;
    c)
        setxkbmap -layout us -variant colemak_dh
        ;;
esac
