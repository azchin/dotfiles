#!/bin/sh
[ $# -lt 1 ] && exit 1
DISPLAY=:1 $@
