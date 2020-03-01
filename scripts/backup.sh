#!/bin/sh

if [ $(sudo timeshift --list | wc -l) -ge 10 ] ; then
	echo "0" | sudo timeshift --delete --scripted
fi

sudo timeshift --create
