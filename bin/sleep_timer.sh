#!/bin/sh

# Suspends laptop 2 minutes after screensaver kicks in (as long as the
# screensaver is still running at that point).
# Template from arch linux forums: 
# https://bbs.archlinux.org/viewtopic.php?id=147773
# https://www.linuxquestions.org/questions/slackware-14/suspend-on-inactivity-4175604195/

PAUSE=5m
# Caveat: should have screen blank time > $PAUSE

process()
{
	while read INPUT
	do
		case "$INPUT" in
			BLANK*)
				# Wait PAUSE and check to make sure it is blanked
				sleep $PAUSE
				local ISBLANKED=$(xscreensaver-command -time | grep ' blanked')
				if [ "$ISBLANKED" != "" ]; then
					loginctl suspend
				fi
				;;
		esac
	done
}

xscreensaver-command -watch | process
