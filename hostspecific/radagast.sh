#!/bin/bash
# radagast.sh -- created 02-Mar-2017, Ken Guest
# @Revision:    0.0

export DC=~/dev/code
export PATH=$PATH:/home/kguest/.cabal/bin

hg_ps1() {
    hg prompt " [{branch}{update}]" 2> /dev/null
}

export PS1='\[\e[1;29m\]\u@\h\[\e[0m\]\[\e[1;33m\]$(hg_ps1) \[\e[0m\]\[\e[1;29m\]\[\e[0m\]\w $ '

# vi: 
