SUDO="doas --"
doas-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == $SUDO\ * ]]; then
        LBUFFER="${LBUFFER#$SUDO }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="$SUDO $LBUFFER"
    fi
}
zle -N doas-command-line
# Defined shortcut keys: [Esc] [Esc]
bindkey -M emacs '\e\e' doas-command-line
bindkey -M vicmd '^s' doas-command-line
bindkey -M viins '^s' doas-command-line

