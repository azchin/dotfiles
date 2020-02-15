#!/bin/zsh

# edit this, printing is inefficient

print_message () {

    local messages
    local message

    messages=(
        "Boooo!"
        "Wow! That was impressively wrong!"
        "Pathetic"
        "The worst one today!"
        "lol"
        "u suk"
        "lol... plz"
        "plz uninstall"
        "ERROR_INCOMPETENT_USER"
        "Incompetence is also a form of competence"
        "Bad."
        "Nice try."
        "What if... you type an actual command the next time!"
        "What if I told you... it is possible to type valid commands."
        "Y u no speak computer???"
        "This is not Windows"
        "Perhaps you should leave the command line alone..."
        "Please step away from the keyboard!"
        "error code: 1D10T"
        "Pro tip: type a valid command!"
        "Go outside."
        "This is not a search engine."
        "(╯°□°）╯︵ ┻━┻"
        "¯\\_(ツ)_/¯"
        "So, I'm just going to go ahead and run rm -rf / for you."
        "Why are you so stupid?!"
        "Perhaps computers is not for you..."
        "I am _seriously_ considering 'rm -rf /'-ing myself..."
        "Are you even trying?!"
        "Try using your brain the next time!"
        "My keyboard is not a touch screen!"
        "Commands, random gibberish, who cares!"
        "Typing incorrect commands, eh?"
        "Are you always this stupid or are you making a special effort today?!"
        "Brains aren't everything. In your case they're nothing."
        "I don't know what makes you so stupid, but it really works."
        "Keep trying, someday you'll do something intelligent!"
    )

    # If CMD_NOT_FOUND_MSGS array is populated use those messages instead of the defaults
    [[ -n ${CMD_NOT_FOUND_MSGS} ]] && messages=( "${CMD_NOT_FOUND_MSGS[@]}" )

    # If CMD_NOT_FOUND_MSGS_APPEND array is populated append those to the existing messages
    [[ -n ${CMD_NOT_FOUND_MSGS_APPEND} ]] && messages+=( "${CMD_NOT_FOUND_MSGS_APPEND[@]}" )

    # Seed RANDOM with an integer of some length
    RANDOM=$(od -vAn -N4 -tu < /dev/urandom)

    # Print a randomly selected message, but only about half the time to annoy the user a
    # little bit less.
    if [[ $((${RANDOM} % 2)) -lt 1 ]]; then
        message=${messages[${RANDOM} % ${#messages[@]}]}
        printf "\n  $(tput bold)$(tput setaf 1)${message}$(tput sgr0)\n\n" >&2
    fi
}

function_exists () {
    # Zsh returns 0 even on non existing functions with -F so use -f
    declare -f $1 > /dev/null
    return $?
}

#
# The idea below is to copy any existing handlers to another function
# name and insert the message in front of the old handler in the
# new handler. By default, neither bash or zsh has has a handler function
# defined, so the default behaviour is replicated.
#
# Also, ensure the handler is only copied once. If we do not ensure this
# the handler would add itself recursively if this file happens to be
# sourced multiple times in the same shell, resulting in a neverending
# stream of messages.
#

#
# Zsh
#
if function_exists command_not_found_handler; then
    if ! function_exists orig_command_not_found_handler; then
        eval "orig_$(declare -f command_not_found_handler)"
    fi
else
    orig_command_not_found_handler () {
        printf "zsh: command not found: %s\n" "$1" >&2
        return 127
    }
fi

command_not_found_handler () {
    print_message
    orig_command_not_found_handler "$@"
}


#
# Bash
#
#if function_exists command_not_found_handle; then
#    if ! function_exists orig_command_not_found_handle; then
#        eval "orig_$(declare -f command_not_found_handle)"
#    fi
#else
#    orig_command_not_found_handle () {
#        printf "%s: %s: command not found\n" "$0" "$1" >&2
#        return 127
#    }
#fi
#
#command_not_found_handle () {
#    print_message
#    orig_command_not_found_handle "$@"
#}
