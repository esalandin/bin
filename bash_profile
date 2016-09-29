#!/bin/false
# to be sourced-in, or ln -s ~/bin/bash_profile ~/.bash_profile
if [ -f "$HOME/bashrc_debug" ]; then
    set -x;
fi
PS1="[\u@\h \W]\$ "

pathadd() {
    if [ -d "$1" -a ":$PATH:" != *":$1:"* ]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

pathadd "$HOME/bin"
pathadd "$HOME/workspace/bin"

unset -f pathadd
