#!/bin/sh
pkill -x screenkey
[ $? -ne 0 ] && screenkey -s small -t 2
