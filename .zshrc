#export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.6.0/bin:$HOME/scripts:$PATH

# [[ -f ~/.bashrc ]] && . ~/.bashrc
source ~/.config/profile
source ~/.config/aliases

stty -ixon -ixoff

autoload -U compaudit compinit
compinit -u -C -d "$XDG_CACHE_HOME/zcompdump"

for config_file ($ZSH/*.zsh) ; do source $config_file ; done
source $ZSH/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export fpath=($ZSH/zsh-completions/src $fpath)
source $ZSH/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/bin/insulter.zsh

# User configuration

HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob notify
unsetopt autocd beep

_comp_options+=(globdots)   # Include hidden files
zstyle ':completion:*' special-dirs false

# if ! [[ "$TERM" =~ "dvtm" ]] ; then
# 	echo -ne '\e[2 q'
# 	dvtm
# fi

~/bin/termstart.sh
