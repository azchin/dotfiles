
# vi mode
bindkey -v
export KEYTIMEOUT=1

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -v '^?' backward-delete-char
if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey -v "${terminfo[kdch1]}" delete-char            # [Delete] - delete forward
else
  bindkey -v "^[[3~" delete-char
  bindkey -v "^[3;5~" delete-char
  bindkey -v "\e[3~" delete-char
fi

if [[ "${terminfo[kcbt]}" != "" ]]; then
	bindkey -v "${terminfo[kcbt]}" reverse-menu-complete
fi

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect '^?' send-break

function zle-keymap-select {
	if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]] ; then
		echo -ne '\e[2 q'
	elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || 
		[[ ${KEYMAP} = '' ]] || [[ $1 = 'beam' ]] ; then
		echo -ne '\e[6 q'
	fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init
echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} # Use beam shape cursor for each new prompt.

autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

