#!/bin/bash
# prompt.sh -- created 14-Jun-2017, Ken Guest
# @Revision:    0.0

#the following PROMPT_COMMAND value isn't useful at the console...
if [ "$TERM" != "linux" ] ; then
       export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME} : : ${PWD}\007"'
fi
export PS1='[\u@\h \W]\$ '

noColor='\[\033[0m\]'
blackColor='\[\033[0;30m\]'
redColor='\[\033[0;31m\]'
greenColor='\[\033[0;32m\]'
yellowColor='\[\033[0;33m\]'
blueColor='\[\033[0;34m\]'
purpleColor='\[\033[0;35m\]'
cyanColor='\[\033[0;36m\]'
greyColor='\[\033[0;37m\]'

boldGrayColor='\[\033[1;30m\]'
boldRedColor='\[\033[1;31m\]'
boldGreenColor='\[\033[1;32m\]'
boldYellowColor='\[\033[1;33m\]'
boldBlueColor='\[\033[1;34m\]'
boldPurpleColor='\[\033[1;35m\]'
boldCyanColor='\[\033[1;36m\]'
boldWhiteColor='\[\033[1;37m\]'

_HOST_COLOR=$noColor
_USER_COLOR=$noColor
if hostname -f | grep -q '\.blanchardstown\.local'; then
    _HOST_COLOR=$redColor
fi
if hostname -f | grep -q '\.vm'; then
    _HOST_COLOR=$greenColor
fi

export PS1="${_USER_COLOR}\u@${noColor}${_HOST_COLOR}\H${noColor} \w $ "
if [[ $EUID -eq 0 ]]; then
    _USER_COLOR=$redColor
    export PS1="${_USER_COLOR}\u@${noColor}${_HOST_COLOR}\H${noColor} \w # "
fi

# vi: 
