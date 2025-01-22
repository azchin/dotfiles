# VIRTUAL_ENV_DISABLE_PROMPT=true

nl='
'
#if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ] || [ "$TERM" = "linux" ] ; then
# #PROMPT='%B%{$fg[green]%}%n@%M%{$fg[white]%}:%{$fg[blue]%}%~%{$reset_color%}$%b '	
#	[[ $TERM =~ "256color" ]] && \
#	PROMPT="%B%F{10}%n@%M%f:%F{12}%~%f%b%F{10}${nl}$%f " || \
# PROMPT="%B%F{green}[%n@%M%f %F{blue}%~%f%F{green}]${nl}$%f%b "
# else
#  source ~/zsh/bullet-train.zsh-theme
# fi

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

# dir="%F{cyan}%64<...<%~%<<%f" # 36
# prm="%F{green}λ %f"
# date="%F{yellow}%D{%T}%f"
# mach="%F{green}%n%F{black}@%F{${mach_color}}%M%f" # one with username
# PROMPT="%B%F{green}[${mach} %F{cyan}${dir}%F{green}] ${err}%F{green}${prm}%f%b"
# PROMPT="%B%F{green}${err}${date} ${cur} ${prm}%f%b"

err="%0(?:%F{green}>>:%F{red}%?)"
prm="%F{green}%#%f"
cur="%F{cyan}%5~%f"
mach_color="yellow"
if [ -n "$SSH_TTY" ]; then
    mach_color="magenta"
fi
mach="%F{${mach_color}}%M%f"
PROMPT="%B%F{green}${err}%f %D{%H:%M %S} ${mach} ${cur} ${prm} %f%b"

RPROMPT='${vcs_info_msg_0_}'


# export ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}✔%F{15}"
# export ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}✘%F{15}"
# export ZSH_THEME_GIT_PROMPT_ADDED=" %F{green}✚%F{15}"
# export ZSH_THEME_GIT_PROMPT_MODIFIED=" %F{blue}✹%F{15}"
# export ZSH_THEME_GIT_PROMPT_DELETED=" %F{red}✖%F{black}"
# export ZSH_THEME_GIT_PROMPT_UNTRACKED=" %F{yellow}✭%F{black}"
# export ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
# export ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
# export ZSH_THEME_GIT_PROMPT_BEHIND=" ⬇"
# export ZSH_THEME_GIT_PROMPT_AHEAD=" ⬆"
# export ZSH_THEME_GIT_PROMPT_DIVERGED=" ⬍"
# export ZSH_THEME_GIT_PROMPT_SUFFIX=""
#
# export ZSH_THEME_GIT_PROMPT_PREFIX="\ue0a0 "
# export ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}\u2713%F{15}"
# export ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}x%F{15}"
# export ZSH_THEME_GIT_PROMPT_ADDED=" %F{green}+%F{15}"
# export ZSH_THEME_GIT_PROMPT_MODIFIED=" %F{blue}~%F{15}"
# export ZSH_THEME_GIT_PROMPT_DELETED=" %F{red}-%F{black}"
# export ZSH_THEME_GIT_PROMPT_UNTRACKED=" %F{yellow}*%F{black}"
# export ZSH_THEME_GIT_PROMPT_RENAMED=" \u2192"
# export ZSH_THEME_GIT_PROMPT_UNMERGED=" ="
# export ZSH_THEME_GIT_PROMPT_BEHIND=" \u2193"
# export ZSH_THEME_GIT_PROMPT_AHEAD=" \u2191"
# export ZSH_THEME_GIT_PROMPT_DIVERGED=" \u2195"
# export ZSH_THEME_GIT_PROMPT_SUFFIX=""

# git_prompt() {
# 	local ref
# 	ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
# 	ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
# 	echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
# }
# git_dirty() {
# 	[ -n "$(command git status --porcelain 2>/dev/null)" ] && \
#     echo "$ZSH_THEME_GIT_PROMPT_DIRTY" || \
#     echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
# }

# autoload -Uz vcs_info
# zstyle ':vcs_info"*' enable git
# formats="\ue0a0 %b%c%u"
# formats="$(echo "\ue0a0") %c%u%b"
# local actionformats="${formats}%{${fg[default]}%} ${PRCH[sep]} %{${fg[green]}%}%a"
# zstyle    ':vcs_info:git*' formats           "$formats"
# zstyle    ':vcs_info:git*' stagedstr         '%F{green}+ '
# zstyle    ':vcs_info:git*' unstagedstr       '%F{red}* '
# zstyle    ':vcs_info:git*' check-for-changes         true
# zstyle    ':vcs_info:git*' check-for-staged-changes  true
# precmd() { vcs_info }

# zstyle ':vcs_info"*' enable git
# () {
# 	local formats="\ue0a0 %b%c%u"
# 	# local actionformats="${formats}%{${fg[default]}%} ${PRCH[sep]} %{${fg[green]}%}%a"
# 	zstyle    ':vcs_info:git*' stagedstr         'hullo'
# 	zstyle    ':vcs_info:git*' unstagedstr       'goodbye'
# 	zstyle    ':vcs_info:git*' formats           "$formats"
# }
# add-zsh-hook precmd vcs_info

# source ~/zsh/bullet-train.zsh-theme
