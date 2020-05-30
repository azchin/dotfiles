#!/bin/sh

input=${1:-"$HOME/bin/configs/cmd.ini"}
options=$(grep -E "^[^#].+=.+" "$input" | cut -d '=' -f 1)
echo $options
select=$(echo "$options" | dmenu -i -p "Execute")
comm=$(grep -E "^$select=" "$input")
[ ! -z "$comm" ] && $(echo "$comm" | cut -d '=' -f 2- | sh) || $select

