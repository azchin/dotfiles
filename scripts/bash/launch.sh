#!/bin/bash

declare -A config
options=""
while read line ; do
	if echo $line | grep -F = >/dev/null 2>&1; then
		key=$(echo $line | cut -d '=' -f 1)
		options="${options}\n${key}"
		config["$key"]=$(echo $line | cut -d '=' -f 2-)
	fi
done < "$1"

comm=$(echo -e $options | cut -d $'\n' -f 2- | dmenu -i)
[[ -v config["$comm"] ]] && ${config["$comm"]} || $comm

