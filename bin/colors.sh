#!/usr/bin/env bash
set -eu
foo() {
    i=$1
    colour=$2
    o=00$i
    width=14
    prefix=""
    if [ $i -ge 8 ]; then
        prefix="Bright"
        width=$((width - 6))
    fi
    printf "${o:${#o}-3:3} ${prefix}%${width}s " "$colour"
    echo -e `tput setaf $i; tput setab $i`${y// /=}$x
}

x=`tput op` 
y=`printf %76s`
colors=("Black" "Red" "Green" "Yellow" "Blue" "Magenta" "Cyan" "White")
for i in {0..15}; do 
    j=$((i % 8))
    colour=${colors[$j]}
    foo $i "$colour"
done
