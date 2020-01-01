#!/bin/bash

# Terminate all current instances of polybar
killall -q polybar

# Wait until all processes are shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch polybar using default config at ~/.config/polybar/config
polybar main &

echo "Polybar launched "
