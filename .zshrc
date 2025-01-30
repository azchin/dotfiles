# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ linux ]] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]]; then
# if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ "$TERM" = alacritty ]] ; then
#     if [ $(tmux list-sessions | wc -l) -le 0 ]; then
#         exec tmux
#     # else
#     #     exec tmux attach
#     fi
# fi

stty -ixon -ixoff
source ~/.config/profile
source ~/.config/aliases

autoload -U compaudit compinit
compinit -u -C -d "$XDG_CACHE_HOME/zcompdump"

for config_file ($ZSH/*.zsh) ; do source $config_file ; done

# source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# export fpath=($ZSH/zsh-completions/src $fpath)
# source $ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/bin/insulter.zsh

declare -A ZINIT
export ZINIT[HOME_DIR]="$XDG_CONFIG_HOME/zsh/zinit"
source $ZSH/zinit/bin/zinit.zsh
zinit ice wait lucid
zinit light zsh-users/zsh-autosuggestions
zinit ice wait lucid
zinit light zsh-users/zsh-completions
zinit ice wait lucid
zinit light zsh-users/zsh-syntax-highlighting
zinit light mafredri/zsh-async
# zinit light jeffreytse/zsh-vi-mode
source $ZSH/order/git-async.zsh

# source $ZSH/zinit/plugins/zsh-users---zsh-autosuggestions/zsh-autosuggestions.zsh
# source $ZSH/zinit/plugins/zsh-users---zsh-completions/zsh-completions.plugin.zsh
# source $ZSH/zinit/plugins/zsh-users---zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source $ZSH/zinit/plugins/mafredri---zsh-async/async.zsh
# source $ZSH/order/git-async.zsh
# export fpath=($ZSH/completions $fpath)

# User configuration

HISTSIZE=10000
SAVEHIST=10000
setopt auto_cd append_history extended_history extended_glob inc_append_history_time interactive_comments notify
unsetopt beep

_comp_options+=(globdots)   # Include hidden files
zstyle ':completion:*' special-dirs false

[ -x ~/bin/termstart.sh ] && ~/bin/termstart.sh
command -v direnv && eval "$(direnv hook zsh)"
:
