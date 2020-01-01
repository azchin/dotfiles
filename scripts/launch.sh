#!/bin/sh

options=$(grep -E "^[^#].+=.+" "$1" | cut -d '=' -f 1)
select=$(echo "$options" | dmenu -i -p "Execute")
comm=$(grep -E "^$select=" "$1")
[ ! -z "$comm" ] && $(echo "$comm" | cut -d '=' -f 2- | sh) || $select

