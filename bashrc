# .bashrc

# User specific aliases and functions
#general stuff for all my .bashrc files.

# Settings in this file are only for interactive shells.
# I don't know why bash loads this file for scp etc.,
# but return if that's the case.
[ "$PS1" ] || return


export LESSCHARSET=utf-8
# Tell less to display colours, and use smartcase searching
# Also don't wrap lines, as less supports horizontal scolling
# Note setting Q to use the visible bell, may cause delays.
export LESS="-RSi"
#stty erase 

alias ..="cd .."        #go to parent dir
alias ...="cd ../.."    #go to grandparent dir
alias s='cd ..'
alias ss='cd ../..'
alias d='ls --color=tty'
alias p='cd -'
alias ll='ls -l --color=tty'
alias l.='ls -d .[a-zA-Z]* --color=tty'
alias ls="BLOCK_SIZE=\'1 ls --color=auto" #enable thousands grouping and colour
alias cls=clear
alias bother='sudo $(history -p \!\!)' #execute previous command through sudo
alias tlf='tail -f'
# GREP_COLOR=bright yellow on black bg.
# use GREP_COLOR=7 to highlight whitespace on black terminals
# LANG=C for speed. See also: http://www.pixelbeat.org/scripts/findrepo
alias grep='GREP_COLOR="1;33;40" LANG=C grep --color=auto'

alias cfgrep='find . -type f -name \*cf? | xargs grep --color=auto'
alias cssgrep='find . -type f -name \*css | xargs grep --color=auto'
alias jsgrep='find . -type f -name \*js | xargs grep --color=auto'
alias phpgrep='find . -type f -name \*php  -print0  -or -type f -name \*phtml -print0 | xargs -0 grep --color=auto'
alias cfegrep='find . -type f -name \*cf?  -print0 | xargs -0 egrep --color=auto'
alias cssegrep='find . -type f -name \*css -print0 | xargs -0 egrep --color=auto'
alias php_beautifier='php_beautifier -l "Pear() KeepEmptyLines() BreakLongLists() SpaceOpAssignments() SpaceCasts()"'
alias phpegrep='find . -type f -name \*php -print0 -or -type f -name \*phtml -print0 | xargs -0 egrep --color=auto'
alias phpshorttagscan='phpcs --sniffs=Generic.PHP.DisallowShortOpenTag'
alias phpcscompat='phpcs --standard=PHPCompatibility'
alias findoldphpconstructors='phpcs --standard=Squiz --extensions=php --sniffs=Generic.NamingConventions.ConstructorName .'
alias vimmru='grep ":e " ~/.viminfo  | cut -f2 -d\  | cat -n'
alias head='head -n $((${LINES:-12}-2))' #as many as possible without scrolling
alias tail='tail -n $((${LINES:-12}-2)) -s.1' #Likewise, also more responsive -f
alias hd='od -Ax -tx1z -v'

# don't put duplicate lines or lines starting with space in the history.
#export HISTCONTROL="ignoredups"
# Don't store duplicate adjacent items in the history
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
export PS1='\[\e[1;29m\]\u@\h\[\e[0m\]\[\e[1;33m\] \[\e[0m\]\[\e[1;29m\]\[\e[0m\]\w $ '
if [ -f ~/dotfiles/prompt.sh ]; then
    . ~/dotfiles/prompt.sh
fi

#make filename completion ignore .o, .pyc and *~ files.
export FIGNORE=".o:~:.pyc"
#and the same for globs
export GLOBIGNORE=".o:~:.pyc"
# Need for a xterm & co if we don't make a -ls
[ -n $DISPLAY ] && {
	[ -f /etc/profile.d/color_ls.sh ] && source /etc/profile.d/color_ls.sh
	 export XAUTHORITY=$HOME/.Xauthority
}
# Read first /etc/inputrc if the variable is not defined, and after the /etc/inputrc 
# include the ~/.inputrc
#[ -z $INPUTRC ] && export INPUTRC=/etc/inputrc
export EDITOR=vim

if [ -f ~/dotfiles/work.bashrc ]; then
	. ~/dotfiles/work.bashrc
fi
if [ -f ~/dotfiles/hostspecific/`hostname`.sh ]; then
	. ~/dotfiles/hostspecific/`hostname`.sh
fi

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
source ~/dotfiles/bash_completion
source ~/dotfiles/git-completion.bash
source ~/dotfiles/pearcompletion.sh
source ~/dotfiles/svnen.sh
#{{{ unarc function for unarchiving files
function unarc () {
# Nice unarcing shell function. Does most common things.
   START=$SECONDS
   for i in $*
     do
        if [ "`echo $i | grep bz2`" != "" ] ; then
            echo Unarchiving bzipped tarfile $i...
            nice bzip2 -dc $i | tar xf -  2>&1
        elif [ "`echo $i | grep zip`" != "" ] ; then
            echo Unarchiving pkzipped file $i...
            nice unzip -q $i  2>&1
        elif [ "`echo $i | grep tar.gz`" != "" ] ; then
            echo Unarchiving gzipped tarfile $i...
            nice gzip -dc $i | tar xf -  2>&1
        elif [ "`echo $i | grep tgz`" != "" ] ; then
            echo Unarchiving gzipped tarfile $i...
            nice gzip -dc $i | tar xf -  2>&1
        elif [ "`echo $i | grep tar.Z`" != "" ] ; then
            echo Unarchiving gzipped tarfile $i...
            nice gzip -dc $i | tar xf -  2>&1
        elif [ "`echo $i | grep tar$`" != "" ] ; then
            echo Unarchiving rared file $i...
            nice tar -xvf $i 2>&1 
        elif [ "`echo $i | grep rar`" != "" ] ; then
            echo Unarchiving rared file $i...
            nice unrar x $i 2>&1
        else:
            echo Unarchiving tarfile $i...
            nice tar xf $i
        fi
     done
   echo Done in `expr $SECONDS - $START` seconds.
}
#}}}

function ssh-ping () {
    for i in $*
        do
            nc -w 1 -z $i 22 > /dev/null && echo "$i is accessible" || echo "$i is not accessible"
        done
}
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi
alias findoldphpconstructorsToCSV="phpcs --standard=Squiz --report=csv  --extensions=php --sniffs=Generic.NamingConventions.ConstructorName . | cut -f1,2 -d,"
export APPLICATION_ENV='development'
export PATH="$PATH:$HOME/bin"
if [ -f ~/.bash-git-prompt/gitprompt.sh ]; then
    GIT_PROMPT_ONLY_IN_REPO=1
    source ~/.bash-git-prompt/gitprompt.sh
fi
