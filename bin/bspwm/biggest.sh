#!/bin/sh

bspc node -s biggest.local || bspc node -s last.local
bspc node -f biggest.local 
