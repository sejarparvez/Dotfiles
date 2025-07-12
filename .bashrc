# ~/.bashrc: executed by bash for non-login shells.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Set a basic prompt
PS1='\u@\h:\w\$ '

# Enable color support for ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi


# enable bash completion in interactive shells
if [ -f /usr/share/bash-completion/bash_completion ]; then
  . /usr/share/bash-completion/bash_completion
fi


# Some basic aliases
alias ll='ls -l'
alias la='ls -a'
alias l='ls -CF'

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

. "$HOME/.cargo/env"
