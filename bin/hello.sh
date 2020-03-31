#!/bin/sh

#st echo hello world
#declare -A arr
#arr["key"]="echo hello world"
#opt=$(echo -e "hello\nworld\nkey" | dmenu) 
#[[ -v arr["$opt"] ]] && ${arr["$opt"]} || $opt
var=$(echo hello world)
echo $var

