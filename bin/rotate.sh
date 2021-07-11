#!/bin/sh
for file in *.jpg; do
  # convert "$file" -rotate 90 "${file%.jpg}"_rotated.jpg
  convert "$file" -rotate 90 "$file"
done
