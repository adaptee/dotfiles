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

# pacman-color is more user-friendly
which pacman-color >& /dev/null &&  alias pacman='pacman-color'

# no boring confimration!
alias yaourt='yaourt --noconfirm'

# install missing dependency automatically
alias makepkg='makepkg -s'


#---------------------------------------------------------------------------#
#                                 package management                        #
#---------------------------------------------------------------------------#

# installl new package
# [Example] add firefox
function add ()
{
    yaourt -S --noconfirm "$@"
}

# remove existing package
# [Example] purge firefox
function purge ()
{
    yaourt -Rs --noconfirm "$@"
}

function update ()
{
    yaourt -Syy
}

function upgrade ()
{
    yaourt -Su --devel
}

function clean ()
{
    sudo rm /var/cache/pacman/pkg/* 2>/dev/null
}

# list all installed packages
function world ()
{
    yaourt -Q
}

# list all availabe packages from the repos
function all ()
{
    true
}

# list what are contained within specified package
# [Example] list firefox
function list ()
{
    pacman -Ql "$1"
}

# which package own the specified file?
# [Example] own /usr/bin/vim
function own ()
{
    pacman -Qo "$1"
}

# search package by name
# [Example] search firefox
function search ()
{
    yaourt -Ss "$1"
}

# show the meta info of specified package
# [Example] meta firefox
function meta ()
{
    pacman -Qi "$1"
}



# mark packages as explicited installed
function explicit ()
{
    sudo pacman -S --noconfirm --asexplicit "$@"
}

# list all un-needed packages
function nouse ()
{
    pacman -Qtdq
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

# grep the list of installed packages
function pac-grep()
{
    pacman -Q | grep -i "$1"
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



#---------------------------------------------------------------------------#
#                                 service management                        #
#---------------------------------------------------------------------------#


# start service
# [Example] start smbd
function start ()
{
    sudo /etc/rc.d/${1} start
}

# stop service
# [Example] stop smbd
function stop ()
{
    sudo /etc/rc.d/${1} stop
}

# restart service
# [Example] restart smbd
function restart ()
{
    sudo /etc/rc.d/${1} restart
}

