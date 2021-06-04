#!/bin/sh

app=${1:=dmenu}
# input=${1:-"$HOME/bin/configs/cmd.ini"}
input=$HOME/.config/launch-commands.ini
options=$(grep -E "^[^#;].+=.+" "$input" | cut -d '=' -f 1)
echo $options
select=$(echo "$options" | $app -i -p "Execute")
comm=$(grep -E "^$select=" "$input")
[ ! -z "$comm" ] && $(echo "$comm" | cut -d '=' -f 2- | sh) || $select

