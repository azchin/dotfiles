#!/bin/sh
if [ "$1" = "on" ] ; then
	cp $XDG_DATA_HOME/alsa/asoundrc-usb $HOME/.asoundrc
elif [ "$1" = "off" ] ; then
	cp $XDG_DATA_HOME/alsa/asoundrc-def $HOME/.asoundrc
elif [ -n "$(grep "^\ *2" /proc/asound/cards)" ] ; then
	cp $XDG_DATA_HOME/alsa/asoundrc-usb $HOME/.asoundrc
else
	cp $XDG_DATA_HOME/alsa/asoundrc-def $HOME/.asoundrc
fi

