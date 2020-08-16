#!/bin/sh

curl wttr.in
wttr()
{
    # change Paris to your default location
    local request="wttr.in/${1-Vancouver}"
    [ "$(tput cols)" -lt 125 ] && request+='?n'
    curl -H "Accept-Language: ${LANG%_*}" --compressed "$request"
}
