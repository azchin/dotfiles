#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.6.0/bin:$HOME/scripts:$PATH

export EDITOR="vi"
export VISUAL="vi"
export TERMINAL="st"
export BROWSER="firefox"
#export RANGER_LOAD_DEFAULT_RC=false

# pfetch config
export PF_INFO="ascii title os kernel pkgs wm shell palette"
export PF_COL1=4
export PF_COL2=8
export PF_COL3=3
export PF_ASCII="arch"

stty -ixon

#export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
#export CLICOLORS=1
#export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

eval $(ssh-agent -s) &>/dev/null
ssh-add ~/.ssh/id_rsa &>/dev/null

# Aliases
alias v='xclip -o -sel clip'
alias c='xclip -o | xclip -sel clip'
alias slep='systemctl suspend'
alias shut='systemctl poweroff'
alias rez='systemctl reboot'
alias hib='systemctl hibernate'
alias open='xdg-open'
alias dots='git --git-dir=$HOME/projects/dotfiles/ --work-tree=$HOME'

alias g++14="g++ -std=c++14 -Wall -g"
