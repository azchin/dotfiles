#!/bin/sh

killall pipewire
killall emacs
killall firefox
~/bin/tmux-killall.sh
killall urxvtd

rm ~/.config/brave-flags.conf
rm ~/.config/electron-flags.conf
