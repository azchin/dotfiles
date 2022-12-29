#!/bin/sh

_USER=andrew

xrandr | grep "XWAYLAND" 2>&1 1>/dev/null && exit
[ ! -f "/home/$_USER/.Xauthority" ] && exit

export DISPLAY=:0
export XAUTHORITY=/home/$_USER/.Xauthority

if [ "$USER" = "$_USER" ] ; then
    { /usr/bin/autorandr --change; $HOME/bin/wallpaper.sh; } &
else
    runuser -w DISPLAY,XAUTHORITY -u $_USER -- /usr/bin/autorandr --change &
    runuser -w DISPLAY,XAUTHORITY -u $_USER -- /home/$_USER/bin/wallpaper.sh &
fi

# connect() {
#     xrandr --output VGA1 --auto
#     xrandr --output LVDS1 --off
# }
 
# disconnect() {
#     xrandr --auto
# }
 
# xrandr | grep "VGA1 connected" &> /dev/null && connect || disconnect
