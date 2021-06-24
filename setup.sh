#!/bin/bash
# setup.sh -- created 20-Mar-2006, Ken Guest
# @Last Change: 20-Mar-2006
# @Revision:    0.0

#if [ ! -f ~/.profile ] ; then
#	ln -sv `pwd`/bashrc ~/.profile
#else
#	echo ".profile already exists"
#fi
if [ ! -f ~/.bashrc ] ; then
	ln -sv `pwd`/bashrc ~/.bashrc
else
	echo ".bashrc already exists"
fi
if [ ! -f ~/.bash_login ] ; then
	ln -sv `pwd`/bashrc ~/.bash_login
else
	echo ".bash_login already exists"
fi
if [ ! -f ~/.bash_profile ] ; then
	ln -sv `pwd`/bashrc ~/.bash_profile
else
	echo ".bash_profile already exists"
fi
if [ ! -f ~/.inputrc ] ; then
	ln -sv `pwd`/.inputrc ~/.inputrc
else
	echo ".inputrc already exists"
fi
if [ ! -f ~/.gitconfig ] ; then
	ln -sv `pwd`/.gitconfig ~/.gitconfig
else
	echo ".gitconfig already exists"
fi

# vi: 
