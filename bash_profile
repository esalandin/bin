#!/bin/false
# to be sourced-in, or ln -s ~/bin/bash_profile ~/.bash_profile
if [ -f $HOME/bashrc_debug ]; then
    set -x;
fi
PS1="[\u@\h \W]\$ "

export DBE_SERVER=dbe-dub2

pathadd() {
    if [ -d "$1" -a ":$PATH:" != *":$1:"* ]; then
        PATH="${PATH:+"$PATH:"}$1"
    fi
}

pathadd $HOME/bin
pathadd /sea/dev/bin
pathadd /sea/local/bin

unset -f pathadd
