#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source ~/.config/profile
source ~/.config/aliases

# export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.6.0/bin:$PATH
#PS1='[\u@\h \W]\$ '
export PS1='\[\033[01;32m\][\u@\h\[\033[00m\] \[\033[01;36m\]\w\[\033[00m\]\[\033[01;32m\]]\$ \[\033[00m\]'
export CLICOLORS=1
export LSCOLORS=ExFxBxDxCxegedabagacad
set -o vi

# disables ^S ^Q (stop and start characters)
stty -ixon -ixoff

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
