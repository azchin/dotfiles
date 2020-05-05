#!/bin/sh

bspc subscribe node_focus | while read -r func monitor desktop node ; do
  echo $node
done
