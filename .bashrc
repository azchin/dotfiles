#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.config/profile
source ~/.config/aliases

# export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.6.0/bin:$PATH

# disables ^S ^Q (stop and start characters)
stty -ixon -ixoff

# eval $(ssh-agent -s) &>/dev/null
# ssh-add ~/.ssh/id_rsa &>/dev/null
