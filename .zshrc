#export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$HOME/.gem/ruby/2.6.0/bin:$HOME/scripts:$PATH

[[ -f ~/.bashrc ]] && . ~/.bashrc

autoload -U compaudit compinit
compinit -u -C -d "~/.zcompdump"

for config_file (~/zsh/*.zsh) ; do source $config_file ; done
source ~/zsh/bullet-train.zsh-theme
source ~/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

_comp_options+=(globdots)   # Include hidden files
zstyle ':completion:*' special-dirs false

