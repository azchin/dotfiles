if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 5 ]; then
    exec startx 2> ~/.xsession-errors
fi
