# autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git
# () {
#     local formats="${PRCH[branch]} %b%c%u"
#     local actionformats="${formats}%{${fg[default]}%} ${PRCH[sep]} %{${fg[green]}%}%a"
#     zstyle ':vcs_info:*:*' formats           $formats
#     zstyle ':vcs_info:*:*' actionformats     $actionformats
#     zstyle ':vcs_info:*:*' stagedstr         "%{${fg[green]}%}${PRCH[circle]}"
#     zstyle ':vcs_info:*:*' unstagedstr       "%{${fg[yellow]}%}${PRCH[circle]}"
#     zstyle ':vcs_info:*:*' check-for-changes true
# }


# _vbe_vcs_info_done() {
#     local stdout=$3
#     vcs_info_msg_0_=$stdout
#     zle reset-prompt
# }

# _vbe_vcs_info() {
# 		cd -q $1
# 		vcs_info
# 		print ${vcs_info_msg_0_}
# }

# source $ZSH/zsh-async/async.zsh
# async_init
# async_start_worker vcs_info
# async_register_callback vcs_info _vbe_vcs_info_done

# add-zsh-hook precmd (){
#     async_job vcs_info _vbe_vcs_info $PWD
# }

# add-zsh-hook precmd vcs_info


# Incorporate git information into prompt
# -*- sh -*-
[[ $USERNAME != "root" ]] && {

    # Async helpers
    _vbe_vcs_async_start() {
        async_start_worker vcs_info
        async_register_callback vcs_info _vbe_vcs_info_done
    }
    _vbe_vcs_info() {
        cd -q $1
        vcs_info
        print ${vcs_info_msg_0_}
    }
    _vbe_vcs_info_done() {
        local job=$1
        local return_code=$2
        local stdout=$3
        local more=$6
        if [[ $job == '[async]' ]]; then
            if [[ $return_code -eq 2 ]]; then
                # Need to restart the worker. Stolen from
                # https://github.com/mengelbrecht/slimline/blob/master/lib/async.zsh
                _vbe_vcs_async_start
                return
            fi
        fi
        vcs_info_msg_0_=$stdout
        [[ $more == 1 ]] || zle reset-prompt
    }

    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    () {
        local formats="\ue0a0 %c%u%b"
        local actionformats="\ue0a0 %c%u%b"
        # local actionformats="${formats}%{${fg[default]}%} ${PRCH[sep]} %{${fg[green]}%}%a"
				zstyle ':vcs_info:git*' check-for-changes true
				zstyle ':vcs_info:git*' check-for-staged-changes true
        zstyle    ':vcs_info:git*' stagedstr         "%F{green}+%f "
        zstyle    ':vcs_info:git*' unstagedstr       "%F{red}*%f "
        zstyle    ':vcs_info:git*' formats           "$formats"
        zstyle    ':vcs_info:*:*' actionformats     $actionformats
        # zstyle    ':vcs_info:*:*' stagedstr         "%{${fg[green]}%}${PRCH[circle]}"
        # zstyle    ':vcs_info:*:*' unstagedstr       "%{${fg[yellow]}%}${PRCH[circle]}"
	# zstyle -e ':vcs_info:*:*' check-for-changes \
               # '[[ $(zstat +blocks $PWD) -ne 0 ]] && reply=( true ) || reply=( false )'
	# zstyle -e ':vcs_info:*:*' check-for-staged-changes \
               # '[[ $(zstat +blocks $PWD) -ne 0 ]] && reply=( true ) || reply=( false )'

        # zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

        # +vi-git-untracked(){
            # [[ $(zstat +blocks $PWD) -ne 0 ]] || return
            # if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
                # git status --porcelain 2> /dev/null | grep -q '??' ; then
                # hook_com[staged]+="%{${fg[black]}%}${PRCH[circle]}"
            # fi
        # }

    }

    # Asynchronous VCS status
    # source $ZSH/zsh-async/async.zsh
    async_init
    _vbe_vcs_async_start
    add-zsh-hook precmd (){
        async_job vcs_info _vbe_vcs_info $PWD
    }
    add-zsh-hook chpwd (){
        vcs_info_msg_0_=
    }

	# PROMPT="${PROMPT}${vcs_info_msg_0_}"
}
