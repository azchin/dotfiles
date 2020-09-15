#zmodload zsh/zpty
ZSH_AUTOSUGGEST_STRATEGY=(history) # match_prev_cmd
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
bindkey -v '^n' autosuggest-accept
bindkey -v '^g' autosuggest-clear
bindkey -v '^p' autosuggest-fetch
bindkey -v '^j' autosuggest-execute
#https://github.com/zsh-users/zsh-autosuggestions#configuration
