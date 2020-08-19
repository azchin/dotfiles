#!/bin/sh

# can try to use `tput` to centre text
# how to handle subscription + clock cycle?
# update either on event or clock cycle

#monitor_id="$(bspc query -M -m)"
#desktop_id="$(bspc query -D -d)"

# node_focus
# separator="|"

# OLDIFS=$IFS
# _redraw() {
# 	lmodules="$storage,$packages,$memory,$cpu,$cpu_temp,$pulseaudio"
# 	cmodules="$bspwm"
# 	rmodules="$wifi,$timedate"
# 	build=""
# 	build="${build}%{l}$separator"
# 	IFS=','
# 	for mod in "$lmodules" ; do
# 		build="${build}${mod}${separator}"
# 	done
# 	build="${build}%{c}$separator"
# 	for mod in "$cmodules" ; do
# 		build="${build}${mod}${separator}"
# 	done
# 	build="${build}%{r}$separator"
# 	for mod in "$rmodules" ; do
# 		build="${build}${mod}${separator}"
# 	done
# 	IFS=$OLDIFS
# 	echo $build
# }

# _clock_cycle() {
#   # make sure to define a function called _fwrap locally in the caller
#   interval=$1
#   while true 
#   do
#     _fwrap
#     sleep $interval
#   done
# }

_filesystem() {
  # Directory path
  dir=$1
  # 1: total size, 2: used, 3: avail, 4: percent
  field=$2
  df -h --output=size,used,avail,pcent "$dir" | awk 'NR == 2 { print $'"${field}"'}'
}

_storage() { # clock based
  # _fwrap() {
	echo "storage $(_filesystem "/" 2) ($(_filesystem "/" 4))"
  # }
  # _clock_cycle 5
}

_ellipsis() {
  name=$1
  wlimit=$2
  [ $(echo "$name" | wc -c) -gt $wlimit ] && \
    name="$(echo -n "$name" | head -c $wlimit)..."
  echo "$name"
}

_node_name() {
  # name=$(xprop -id $1 WM_NAME | sed -E "s/WM_NAME(.*) = //" | tr -d '"')
	name=$(xprop -id $1 WM_NAME | awk -F'"' '{print $2}')
  _ellipsis "$name" 20
}

_node_focus() { # event based
  _node_name "$(bspc query -N -n)"
  bspc subscribe node_focus | while read -r func monitor_id desktop_id node_id
  do
		_node_name $node_id
		# node_focus=$(_node_name $node_id)
		# _redraw
  done
}

_get_volume() {
  [ "$(~/bin/pulseaudio/status.sh mute)" = "no" ] && \
    # echo "$(pulsemixer --get-volume | cut -f1 -d' ')%" \
			echo "$(~/bin/pulseaudio/status.sh volume)%" \
  || \
    echo "mute"
}

_pulseaudio() { # event based
	# pulseaudio=$(_get_volume)
	echo "pulseaudio $(_get_volume)"
  sink=-1
  count=0 #REMOVE
  change=0
  pactl subscribe | while read -r event type on client number
  do
    if [ $change -eq 1 ] && [ "$type" = "'change'" ] ; then
			# _get_volume
			echo "pulseaudio $(_get_volume)"
			# pulseaudio=$(_get_volume)
			# _redraw
      change=0
    elif [ "$type" = "'change'" ] ; then
      change=1
    else
      change=0
    fi
  done
}

_timedate() { # clock based
  # _fwrap() {
	echo "timedate $(date "+%a %b %d, %T %Z")"
  # }
  # _clock_cycle 1
}

_packages() { # event based
	file=/usr/local/share/paccount
	# packages="$(cat $file) pkgs"
	echo "packages $(cat $file) pkgs"
	while inotifywait -q -e modify $file >/dev/null ; do
		echo "packages $(cat $file) pkgs"
		# packages="$(cat $file) pkgs"
		# _redraw
	done
}

cpu_idle=$(awk '/cpu /{print $5 + $6}' < /proc/stat)
cpu_nonidle=$(awk '/cpu /{print $2 + $3 + $4 + $7 + $8}' < /proc/stat)
cpu_total=$(($cpu_idle + $cpu_nonidle))
_cpu() { # clock based
	# _fwrap() {
	prev_idle=$cpu_idle
	prev_total=$cpu_total
	cpu_idle=$(awk '/cpu /{print $5 + $6}' < /proc/stat)
	cpu_nonidle=$(awk '/cpu /{print $2 + $3 + $4 + $7 + $8}' < /proc/stat)
	cpu_total=$(($cpu_idle + $cpu_nonidle))
	cpu_dt=$(($cpu_total - $prev_total))
	cpu_di=$(($cpu_idle - $prev_idle))
	echo "cpu $(echo "(${cpu_dt}-${cpu_di})*100/${cpu_dt}" | bc -l | awk '/.*\../{if($0<1){print 0 substr($0,0,3)}else if($0<100){print substr($0,0,4)}else{print substr($0,0,3)}}')%"
	# echo "cpu $(echo "(${cpu_dt}-${cpu_di})*100/${cpu_dt}" | bc -l | )%"
	# }
	# _clock_cycle 1
}

_memory() { # clock based
	# _fwrap() {
	mem_available=$(awk '/MemAvailable/{print $2}' < /proc/meminfo)
	echo "memory $(echo "${mem_available}/(2^20)" | bc -l | awk '{if($0<1){print 0 substr($0,0,3)}else{print substr($0,0,4)}}')G"
	# }
	# _clock_cycle 1
}

_cpu_temp() { # clock based
	# _fwrap() {
	file=/sys/devices/pci0000:00/0000:00:18.3/hwmon/hwmon0/temp1_input
	echo "cpu_temp $(echo "$(cat $file)/1000" | bc -l | awk '{print substr($0,0,4)}')°C"
	# }
	# _clock_cycle 1
}

_wifi() { # clock based
	device=wlp4s0
	# _fwrap() {
	ssid=$(iw dev $device info | awk '/ssid/{print $2}')
	echo "wifi $(_ellipsis $ssid 16)"
	# }
	# _clock_cycle 2
}

_bspdraw() {
	build=""
	for desk in $(echo $1 | sed "s/:L.*$//;s/^[^:]*://;s/:/ /g") ; do
		# state=${desk:0:1}
		# name=${desk:1}
		state=$(echo $desk | head -c1)
		name=$(echo $desk | tail -c+2)
		case "$state" in
			O|F) # focused occupied # focused unoccupied
				fg="#fba922"
				bg="#3d4247"
				ul="#fba922"
				;;
			o) # unfocused occupied
				fg="#a2a2a2"
				bg="#31363b"
				ul="#ff3daee9"
				;;
			U) # focused urgent
				fg="#f4005f"
				bg="#31363b"
				ul="#f4005f"
				;;
			u) # unfocused urgent
				fg="#f4005f"
				bg="#31363b"
				ul="#f4005f"
				;;
			f|*) # unfocused unoccupied
				fg="#a2a2a2"
				bg=""
				ul=""
		esac
		# build="${build}%{U${ul}}%{B${bg}}%{F${fg}} ${name} %{F-}%{B-}%{U-}"
		build="${build}^bg(${bg})^fg(${fg}) ${name} ^fg()^bg()"
	done
	echo "${build}"
}

_bspwm() { # event based
	bspc subscribe report | while read -r line
	do
		echo "bspwm $(_bspdraw $line)"
		# bspwm=$(_bspdraw $line)
		# _redraw
	done
}

_tray() { # event based
	killall -q stalonetray
	stalonetray -c ~/.config/stalonetray/stalonetrayrc 2>&1 | while read -r line
	do
		width=$(echo "$line" | sed -E -n "s/^geometry.* ([0-9]+)x[0-9]+.*/\1/p")
		[ -n "$width" ] && echo "tray ${width}"
	done
}

_cycle_hit() {
	while true ; do
		# storage=$(_storage)
		# memory=$(_memory)
		# cpu=$(_cpu)
		# cpu_temp=$(_cpu_temp)
		# wifi=$(_wifi)
		# timedate=$(_timedate)
		# _redraw
		_storage
		_memory
		_cpu
		_cpu_temp
		_wifi
		_timedate
		sleep 1
	done
}

_generate() {
	_bspwm &
	_pulseaudio &
	_packages &
	# _tray &
	#_node_focus &
	_cycle_hit &
}

_generate

# Multiple bar draws

# _format() {
# 	$1 | while read -r line
# 	do
# 		echo "%{l}|%{c}$line%{r}|"
# 	done
# }

# # Note: pixelsize 12 = size 9
# # DejaVu Sans Mono has W:H ratio ~= 3:4
# # -> ~ 9 pixels / char
# _lbar() {
#   _format $1 | lemonbar \
#     -f "DejaVu Sans Mono:style=Bold:size=9" \
#     -B "#0f0f0f" \
#     -F "#e5e5e5" \
# 		-U "#0f0f0f" \
# 		-u 3 \
#     -b -p \
#     -g "${width}x${height}+${loffset}+0" \
#     &
#   loffset=$((loffset + width))
# }

# _rbar() {
#   roffset=$((roffset - width))
#   _format $1 | lemonbar \
#     -f "DejaVu Sans Mono:style=Bold:size=9" \
#     -B "#0f0f0f" \
#     -F "#e5e5e5" \
# 		-U "#0f0f0f" \
# 		-u 3 \
#     -b -p \
#     -g "${width}x${height}+${roffset}+0" \
# 		&
# }

# _cpad() {
# 	width=$(($roffset - $loffset))
#   echo "" | lemonbar \
#     -f "DejaVu Sans Mono:style=Bold:size=9" \
#     -B "#0f0f0f" \
#     -F "#e5e5e5" \
# 		-U "#0f0f0f" \
# 		-u 3 \
#     -b -p \
#     -g "${width}x${height}+${loffset}+0" \
#     &
# }

# loffset=0
# roffset=$(( $(xrandr -q | awk '/\*/{print $1}' | cut -dx -f1) - 128 ))
# height=27


# # Left align
# width=91
# _lbar _storage

# width=81
# _lbar _packages

# width=63
# _lbar _cpu

# width=63
# _lbar _memory

# width=72
# _lbar _cpu_temp

# width=45
# _lbar _pulseaudio


# # Right align

# width=198
# _rbar _timedate
# width=144
# _rbar _wifi
# width=270
# _rbar _bspwm


# # width=198
# # _rbar _node_focus


# [ $loffset -gt $roffset ] && ~/bin/lemonbar/kill-lemon.sh
# _cpad
