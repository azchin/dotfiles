#!/bin/sh

sleep_timer.sh
xinput --test-xi2 --root | while read -r line ; do
	killall -q sleep_timer.sh
	sleep_timer.sh
done

