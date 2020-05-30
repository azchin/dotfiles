#export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.6.0/bin:$HOME/scripts:$PATH

# [[ -f ~/.bashrc ]] && . ~/.bashrc
source ~/.config/profile
source ~/.config/aliases

stty -ixon -ixoff

autoload -U compaudit compinit
compinit -u -C -d "~/.zcompdump"

for config_file (~/zsh/*.zsh) ; do source $config_file ; done
source ~/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
export fpath=(~/zsh/zsh-completions/src $fpath)
source ~/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/bin/insulter.zsh

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ "$TERM" = "linux" ] ; then
 #PROMPT='%B%{$fg[green]%}%n@%M%{$fg[white]%}:%{$fg[blue]%}%~%{$reset_color%}$%b '	
	nl='
'
	[[ $TERM =~ "256color" ]] && \
	PROMPT="%B%F{10}%n@%M%f:%F{12}%~%f%b%F{10}${nl}$%f " || \
	PROMPT="%B%F{green}%n@%M%f:%F{blue}%~%f%b%F{green}${nl}$%f "
else
 source ~/zsh/bullet-train.zsh-theme
fi

# nl='
# '
# if [[ $TERM =~ "(256color|alacritty)" ]] ; then
# 	# mach="%F{15}%n%F{14}@%F{15}%M"
# 	mach="%F{15}%n"
# 	dir="%64<...<%~%<<" # 32
# 	err="%0(?:: %F{9}%? )"
# 	prm="${nl}%# "
# 	# dir="%32<...<%5(~:...:)%4~%<<"
# 	# PROMPT="%B%F{10}[%n@%M%f %F{14}%~%f%F{10}]$%b%f "
# 	# PROMPT="%K{0} ${mach} %K{14}%F{\e[4} ${dir} %k ${err}%F{10}${prm}%f"
# 	PROMPT="%K{0} ${mach} %F{11} ${dir} ${err}%k%F{10}${prm}%f"
# else
# 	mach="%F{white}%n"
# 	dir="%64<...<%~%<<" # 36
# 	err="%0(?:: %F{red}%? )"
# 	prm="${nl}%# "
# 	PROMPT="%K{black} ${mach} %F{yellow} ${dir} ${err}%k%F{green}${prm}%f"
# fi

# User configuration

HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob notify
unsetopt autocd beep

_comp_options+=(globdots)   # Include hidden files
zstyle ':completion:*' special-dirs false

command -v pfetch >/dev/null 2>&1 && pfetch || :
