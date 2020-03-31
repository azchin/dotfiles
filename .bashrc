#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PATH=$HOME/bin:$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.6.0/bin:$PATH

export EDITOR="vi"
export VISUAL="nvim"
export TERMINAL="st"
export BROWSER="firefox"
#export RANGER_LOAD_DEFAULT_RC=false
#export MANPAGER="nvim"

# pfetch config
export PF_INFO="ascii title os kernel pkgs shell editor wm"
export PF_COL1=6
export PF_COL2=8
export PF_COL3=3
export PF_ALIGN="10"
export PF_ASCII="arch"

stty -ixon

#export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\n\$ '
#export CLICOLORS=1
#export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias diff='diff --color=auto'

eval $(ssh-agent -s) &>/dev/null
ssh-add ~/.ssh/id_rsa &>/dev/null

# Aliases
#alias v='xclip -o -sel clip'
#alias c='xclip -o | xclip -sel clip'
alias slep='systemctl suspend'
alias shut='systemctl poweroff'
alias rez='systemctl reboot'
alias hib='systemctl hibernate'
alias open='xdg-open'
alias dots='git --git-dir=$HOME/projects/dotfiles.git --work-tree=$HOME'
#[ -f /usr/bin/pfetch ] && alias clear='clear && pfetch'
alias c='clear && pfetch'
alias vi='nvim'
alias color='crunchbang-mini'

alias g++14="g++ -std=c++14 -Wall -g"
alias glg="git log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
alias dlg="dots log --graph --abbrev-commit --decorate --format=format:'%C(bold green)%h%C(reset) - %C(bold cyan)%aD%C(reset) %C(bold yellow)(%ar)%C(reset)%C(auto)%d%C(reset)%n''          %C(white)%s%C(reset) %C(dim white)- %an%C(reset)' --all"
