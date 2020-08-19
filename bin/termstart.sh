#!/bin/sh

# terminals="alacritty:st:urxvt:"
# search=$(echo $terminals | xargs -d ':' -I _name pgrep "^_name$" | wc -l)
# tmux=$(( $(pgrep "tmux" | wc -l) - 1 ))
# if [ $tmux -ge 0 ] ; then
# 	search=$(($search + $tmux))
# fi
# # search=$([ $(pgrep "tmux" | wc -l) -ge 1 ] && echo $(($search + $tmux)) || echo $search)
# [ "$TERM" = "rxvt-unicode-256color" ] && ~/bin/archlogo.sh && exit 0
# if [ $search -le 1 ] && command -v aperture.sh >/dev/null 2>&1 ; then
# 	aperture.sh
# 	# if command -v aperture.sh >/dev/null 2>&1 ; then
# 	# 	aperture.sh
# 	# elif command -v pfetch >/dev/null 2>&1 ; then
# 	# 	pfetch
# 	# fi
# elif command -v pfetch >/dev/null 2>&1 ; then
# 	pfetch
# fi

# command -v pfetch >/dev/null 2>&1 && pfetch || :

~/bin/tux.sh
