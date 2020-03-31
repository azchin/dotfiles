#!/bin/sh
# Uses mprime/prime95 with Large FFTs for CPU stress test
cd ~/logs/mprime
st htop &
st watch ~/bin/sensors.sh &
echo "15\n\n3\n\n\n" | mprime
