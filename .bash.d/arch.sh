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
    if echo "$1" | grep -E 'pkg\.tar\.(xz|gx)$'  2>&1 >/dev/null ; then
        # add from local archive
        sudo pacman -U "$1"
    else
        # add from online repo or AUR
        yaourt --noconfirm -S --noconfirm "$@"
    fi
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

# inspired by  gentoo
# list all exlicitly installed packages
function world ()
{
    pacman -Qet
}

# list all installed packages
function all ()
{
    yaourt -Q
}

# list all un-needed  packages
function orphan ()
{
    pacman -Qtdq
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

# only the the version of that package
function version()
{
    pacman -Q "$1"
}

# mark packages as explicited installed
function explicit ()
{
    sudo pacman -S --noconfirm --asexplicit "$@"
}

# find out which (installed) package own the command
function owncmd()
{
    local cmdname=$1
    local cmdpath=$(which ${cmdname} 2>/dev/null)

    if [[  "${cmdpath}" == ""  ]] ; then
        echo "command [$cmdname] does not exist!"
    else
        own ${cmdpath}
    fi
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

