#!/bin/sh
for file in $(ls *.jpg *.png) ; do
  convert "$file" -quality 100 "${file}.pdf"
done
