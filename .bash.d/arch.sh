#!/bin/bash
#===============================================================================
#
#          FILE:  arch.sh
#
#         USAGE:  ./arch.sh
#
#   DESCRIPTION:  archlinux specific settging for bash
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  adaptee (), adaptee@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  05/07/10 13:56:59 CST
#      REVISION:  ---
#===============================================================================

alias rsmb='sudo /etc/rc.d/samba restart'

# install missing dependency automatically
alias makepkg='makepkg -s'

# pacman-color is more user-friendly
which pacman-color >& /dev/null &&  alias pacman='pacman-color'

# install package
function pac-add ()
{
    yaourt -S "$@"
}

# search package by name
function pac-search ()
{
    yaourt -Ss "$1"
}

# query  meta-info
function pac-info ()
{
    pacman -Qi "$*"
}

# claer package cache
function pac-clean()
{
    sudo rm /var/cache/pacman/pkg/* 2>/dev/null
}

# mark packages as explicited installed
function pac-explicit ()
{
    sudo pacman -S --noconfirm --asexplicit $@
}

# show package size in ascending order
function pac-size ()
{
    if [[ $# == 0 ]] ; then
        sort -k2 -n ~/.pac-size.list | column -t
    else
        grep "$@" ~/.pac-size.list
    fi
}

# list the commands provided by the package
function pac-bin()
{
    pacman -Ql "$1" | grep  '/bin/'
}

# list the manpages provided by the package
function pac-man()
{
    pacman -Ql "$1" | grep  '/man/'
}

# list the files provided by the package
function pac-list()
{
    pacman -Ql "$1"
}

# grep the list of installed packages
function pac-grep()
{
    pacman -Q | grep -i "$1"
}


# list all un-needed packages
function pac-nouse ()
{
    pacman -Qtdq
}


function update ()
{
    sudo pacman -Syy
}

function upgrade ()
{
    #sudo pacman -Su --noconfirm
    sudo yaourt -Su --devel
}
