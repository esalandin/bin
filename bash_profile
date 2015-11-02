#!/bin/false
# to be sourced-in, or ln -s ~/bin/bash_profile ~/.bash_profile
PATH=${PATH}:$HOME/bin
PS1="[\u@\h \W]\$ "

export DBE_SERVER=dbe-dub2

pathadd() {
    if [ ! -d "$1" ] ; then
        echo "$1 not a directory" >&2
    elif [[ ":$PATH:" == *":$1:"* ]]; then
        echo "$1 already in path" >&2
    else
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

pathadd /sea/dev/bin
pathadd /sea/local/bin
