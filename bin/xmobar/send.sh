#!/bin/sh

# Wakeup
# Reposition
# ChangeScreen
# Hide   Int
# Reveal Int
# Toggle Int
# TogglePersistent
# Action Button Position
arg=""
case $1 in
	hide)
		arg="Hide 0"
		;;
	show)
		arg="Reveal 0"
		;;
	toggle)
		arg="Toggle 0"
		;;
	*)
		arg="$1"
esac

dbus-send \
    --session \
    --dest=org.Xmobar.Control \
    --type=method_call \
    --print-reply \
    '/org/Xmobar/Control' \
    org.Xmobar.Control.SendSignal \
    "string:${arg}"
