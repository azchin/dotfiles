#!/bin/sh

[ $# -lt 1 ] && exit

dir=$1
conf=$(pwd)
dots=~/projects/dotfiles
rm -rf $dots/$dir
mv $conf/$dir $dots
ln -s $dots/$dir $conf/$dir
echo done
