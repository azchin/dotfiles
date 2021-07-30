#!/bin/sh
playerctl $1
case $1 in
    next)
        ICON="media-skip-forward"
        ;;
    previous)
        ICON="media-skip-backward"
        ;;
    play-pause)
        STATUS=$(playerctl status)
        ;;
esac
case $STATUS in
    Playing)
        ICON="media-playback-start"
        ;;
    Paused)
        ICON="media-playback-pause"
        ;;
esac
TITLE=$(playerctl metadata title)
~/bin/notify.sh "$TITLE" "$ICON"
