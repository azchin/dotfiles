#!/bin/sh
# e.g. (inside desktopbg1) cover.sh 1920x1080 ../desktopbg2
[ $# -ne 1 ] && [ $# -ne 2 ] && echo "Usage: $0 dimensions [destination]"
dimensions="$1" # maybe default to 1920x1080
curdir=$(pwd)
newdir=$([ -n "$2" ] && echo "$2" || echo "${pwd}_fill")
[ ! -d "$newdir" ] && mkdir $newdir
for file in $(ls *.jpg *.png) ; do
  convert "$file" -resize "${dimensions}^" \
    -gravity center -extent "$dimensions" "${newdir}/${file}"
done
