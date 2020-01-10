#export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.6.0/bin:$HOME/scripts:$PATH

[[ -f ~/.bashrc ]] && . ~/.bashrc

autoload -U compaudit compinit
compinit -u -C -d "~/.zcompdump"

for config_file (~/zsh/*.zsh) ; do source $config_file ; done
source ~/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] ; then
	#PROMPT='%B%{$fg[green]%}%n@%M%{$fg[white]%}:%{$fg[blue]%}%~%{$reset_color%}$%b '	
	nl='
'
	[[ $TERM =~ "256color" ]] && \
	PROMPT="%F{10}%n@%M%f:%F{12}%~%f%F{10}${nl}$%f " || \
	PROMPT="%F{green}%n@%M%f:%F{blue}%~%f%F{green}${nl}$%f "
else
	source ~/zsh/bullet-train.zsh-theme
fi

# User configuration

_comp_options+=(globdots)   # Include hidden files
zstyle ':completion:*' special-dirs false

