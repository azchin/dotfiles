#!/bin/sh
# _var() {
# 	echo "func"
# }
# var="ble"

# echo $(_var)
# echo $var

# echo $(echo '$'"var")
var="hello ,world,comma,separate"
IFS=','
for i in "$var" ; do
	echo $var
done
