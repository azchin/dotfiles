#!/bin/sh

device=wlp3s0
sudo iw dev "$device" scan | awk '/\sSSID: \w/{print $2}'
