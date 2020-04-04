#!/bin/sh

bspc desktop -f $(bspc query -D --names | dmenu -i -p "Go to desktop")
