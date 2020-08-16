#!/bin/sh

# doesn't fix parenting issue

case "$TERM" in
	alacritty)
		alacritty --working-directory "$(pwd)"
		;;
	rxvt-unicode-256color)
		urxvtc &
		;;
esac
