#!/bin/sh
tmp=$(mktemp)
speedtest > $tmp
grep -E "^(Download|Upload)" $tmp
rm $tmp
read nul
