#!/bin/sh
subv=$([ -z "$1" ] && echo "root" || echo "$1")
case "$subv" in
  home)
    dir="/home"
    ;;
  root)
    dir="/"
    ;;
  *)
    exit 1
    ;;
esac
#echo $dir $subv
sudo btrfs subvolume snapshot -r $dir "/snapshots/@${subv}-$(date +%F)"
