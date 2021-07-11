#!/bin/zsh

declare -A ZINIT
export ZINIT[HOME_DIR]="$XDG_CONFIG_HOME/zsh/zinit"
source $ZSH/zinit/bin/zinit.zsh
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
zinit light mafredri/zsh-async
source $ZSH/order/git-async.zsh
