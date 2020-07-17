#!/bin/bash


# lmodules=(storage packages memory cpu cpu_temp pulseaudio)
# cmodules=(bspwm)
# cmodules=()
lmodules=(bspwm)
cmodules=(storage packages memory cpu cpu_temp pulseaudio)
rmodules=(wifi timedate)
# offset=$(_trayer_geometry)


declare -A mods
_buildbar() {
	build=""
	# build="^p(_LEFT)"
	for item in "${lmodules[@]}" ; do
		 build="${build}- ${mods[$item]} -"
	done
	# build="${build}^p(_CENTER)"
	for item in "${cmodules[@]}" ; do
		 build="${build}- ${mods[$item]} -"
	done
	# build="${build}^p(_RIGHT)"
	for item in "${rmodules[@]}" ; do
		 build="${build}- ${mods[$item]} -"
	done
	echo $build
}
# _buildbar() {
# 	build="%{l} "
# 	for item in "${lmodules[@]}" ; do
# 		 build="${build}${mods[$item]} | "
# 	done
# 	build="${build}%{c}"
# 	for item in "${cmodules[@]}" ; do
# 		 build="${build}${mods[$item]}"
# 	done
# 	build="${build}%{r}"
# 	for item in "${rmodules[@]}" ; do
# 		 build="${build} | ${mods[$item]}"
# 	done
# 	build="${build}%{O$((${mods[tray]} + 3))}"
# 	echo $build
# }

_listen() {
	while read -r line ; do
		module=$(echo "$line" | cut -d' ' -f1)
		mods[$module]=${line#* }
		_buildbar 
		# build=$(echo "$build" | sed "s/^${module} .*/${line}/")
		# echo "$build" | _parse
	done
}

~/bin/lemonbar/modules.sh | _listen | dzen2 -p -ta r -h 27 

# ~/bin/lemonbar/modules.sh | _listen | lemonbar \
# 	-f "DejaVu Sans Mono:style=Bold:size=9" \
# 	-B "#0f0f0f" \
# 	-F "#e5e5e5" \
# 	-U "#0f0f0f" \
# 	-u 3 \
# 	-b -p \
# 	-g "x27++" \
# 	&




# _init() {
# 	delim=" \n"
# 	left="%{l}\n$(echo $lmodules | sed "s/ /${delim}/g")${delim}"
# 	center="%{c}\n$(echo $cmodules | sed "s/ /${delim}/g")${delim}"
# 	right="%{r}\n$(echo $rmodules | sed "s/ /${delim}/g")"
# 	# TODO maybe -n
# 	echo "${left}${center}${right}" 
# }

# _parse() {
# 	build=""
# 	while read -r line ; do
# 		content=$(echo $line | sed "s/^[^ ]* //" | tr '\n' ' ')
# 		build="${build}${content}"
# 	done
# 	echo $build | sed "s/\(%{[l,c,r]}\) /\1/g"
# }
