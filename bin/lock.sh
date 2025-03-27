#!/bin/sh

# slock
#betterlockscreen -l dim && betterlockscreen -u ~/images/lockbg1
# light-locker-command -l 

if [ -n $WAYLAND_DISPLAY ]; then
    loginctl lock-session
else
    XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 \
        XSECURELOCK_PASSWORD_PROMPT=time \
        XSECURELOCK_SHOW_DATETIME=1 \
        xsecurelock
            # XSECURELOCK_FONT='DejaVuSansMono Nerd Font Mono' \
fi

# store=$XDG_CACHE_HOME/lock
# path=~/images/lockbg2
# files=$(ls $path)
# num=$(echo "$files" | wc -w)
# index=$(cat $store)
# echo $(( ( index % num ) + 1 )) > $store

# text=e5e5e5ff
# back=0f0f0fcc
# wrong=1d1f21cc
# font="DejaVu Sans Mono"

# # imagemagick, transform pics to proper resolution
# i3lock -n -i "${path}/$(echo "$files" | sed "${index}q;d")" -e -t \
# 	--indicator -m -k \
# 	--timestr="%T" --time-font="$font" --timesize=32 --timecolor=$text \
# 	--datestr="%F" --date-font="$font" --datesize=20 --datecolor=$text \
# 	--insidevercolor=$back --insidewrongcolor=$wrong --insidecolor=$back \
# 	--ringvercolor=$back --ringwrongcolor=$back --ringcolor=$back \
# 	--keyhlcolor=3daee9ff --bshlcolor=fba922ff \
# 	--veriftext="..." --verif-font="$font" --verifcolor=$text \
# 	--wrongtext="wrong" --wrong-font="$font" --wrongcolor=$text \
# 	--separatorcolor=0f0f0f00 --linecolor=$text \
# 	--noinputtext="empty" --locktext="" \
# 	--radius 160 --ring-width 20.0

	
