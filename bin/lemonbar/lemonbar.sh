#!/bin/sh
# Note: use lemonbar-xft-git

# can try to use `tput` to centre text
# how to handle subscription + clock cycle?
# update either on event or clock cycle

#monitor_id="$(bspc query -M -m)"
#desktop_id="$(bspc query -D -d)"

_clock_cycle() {
  # make sure to define a function called _fwrap locally in the caller
  interval=$1
  while true 
  do
    _fwrap
    sleep $interval
  done
}

_filesystem() {
  # Directory path
  dir=$1
  # 1: total size, 2: used, 3: avail, 4: percent
  field=$2
  df -h --output=size,used,avail,pcent "$dir" | awk 'NR == 2 { print $'"${field}"'}'
}

_storage() {
  _fwrap() {
    echo -n "$(_filesystem "/" 2 | sed -E "s/([K,M,G,T])/ \1/") ($(_filesystem "/" 4))"
  }
  _clock_cycle 5
}

_ellipsis() {
  name=$1
  wlimit=$2
  [ $(echo "$name" | wc -c) -gt $wlimit ] && \
    name="$(echo -n "$name" | head -c $wlimit)..."
  echo -n "$name"
}

_node_name() {
  name=$(xprop -id $1 WM_NAME | sed -E "s/WM_NAME(.*) = //" | tr -d '"')
  _ellipsis "$name" 20
}

_node_focus() {
  _node_name "$(bspc query -N -n)"
  bspc subscribe node_focus | while read -r func monitor_id desktop_id node_id
  do
    _node_name $node_id
  done
}

_get_volume() {
  [ $(pulsemixer --get-mute) -eq 0 ] && \
    echo "$(pulsemixer --get-volume | cut -f1 -d' ')%" \
  || \
    echo "mute"
}

_pulseaudio() {
  _get_volume
  sink=-1
  count=0 #REMOVE
  change=0
  pactl subscribe | while read -r event type on client number
  do
    if [ $change -eq 1 ] && [ "$type" = "'change'" ] ; then
      _get_volume
      change=0
    elif [ "$type" = "'change'" ] ; then
      change=1
    else
      change=0
    fi
  done
}

_timedate() {
  _fwrap() {
    date "+%a %b %d, %T %Z"
  }
  _clock_cycle 1
}

_bar() {
  $1 | lemonbar \
    -f "DejaVu Sans Mono:style=Bold:size=9" \
    -B "#ff0f0f0f" \
    -F "#ffe5e5e5" \
    -b -p \
    -g "${width}x${height}+${offset}+0" \
    &
  offset=$((offset + width))
}

offset=0
height=27

width=600
_bar _timedate 

width=180
_bar _node_focus

width=50
_bar _pulseaudio

width=80
_bar _storage
