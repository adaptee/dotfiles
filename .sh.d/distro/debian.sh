#!/bin/bash

# Dear Ubuntu, I do not need you to telli me which package to install!
unset command_not_found_handle


alias rnet='sudo /etc/init.d/networking restart'
alias rsmb='sudo /etc/init.d/smbd restart'

#---------------------------------------------------------------------------#
#                                 service management                        #
#---------------------------------------------------------------------------#


# start service
# [Example] start smbd
function start ()
{
    sudo /etc/init.d/${1} start
}

# stop service
# [Example] stop smbd
function stop ()
{
    sudo /etc/init.d/${1} stop
}

# restart service
# [Example] restart smbd
function restart ()
{
    sudo /etc/init.d/${1} restart
}

#---------------------------------------------------------------------------#
#                                 package management                        #
#---------------------------------------------------------------------------#

# installl new package
# [Example] add firefox
function add ()
{
    if echo "$1" | grep -E '\.deb$'  2>&1 >/dev/null ; then
        # add from local .deb archive
        sudo dpkg -i "$1"
    else
        # add from online repo or AUR
        local pkgnames
        pkgnames=($(echo $* | tr '[A-Z]' '[a-x]'))
        sudo apt-get install --yes --force-yes  --auto-remove ${pkgnames[@]}
    fi
}

# remove existing package
# [Example] purge firefox
function purge ()
{
    sudo apt-get purge --yes --force-yes --auto-remove "$@"
}

function update ()
{
    sudo apt-get update
}

function upgrade ()
{
    sudo apt-get dist-upgrade --yes --force-yes --verbose-versions
}

function clean ()
{
    sudo apt-get clean
    sudo apt-get autoremove
}

# inspired by gentoo
# list all directly installed packages
function world ()
{
    aptitude search '~i !~M'
}

# list all installed packages
function all ()
{
    dpkg-query -l
}

# list all availabe packages from repos
function universe ()
{
    apt-cache pkgnames
}

# list what are contained within specified package
# [Example] list firefox
function list ()
{
    dpkg-query -L "$1"
}

# which package own the specified file?
# [Example] own /usr/bin/vim
function own ()
{
    apt-file search "$1"
}

# find out which (installed) package own the command
# [example] owncmd amuled
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


# search package by name
# [Example] search firefox
function search ()
{
    apt-cache search -n "$1"
}

# show the meta info of specified package
# [Example] meta firefox
function meta ()
{
    if echo "$1" | grep -E '\.deb$'  2>&1 >/dev/null ; then
        # get info from local .deb archive
        local archivename="$1"
        dpkg --info "$archivename" | tail -n +5
    else
        # get info from dpkg database
        local pkgname
        pkgname=$(echo "$@" | tr '[A-Z]' '[a-x]')
        apt-cache show "$pkgname"
    fi
}

alias syn='sudo synaptic'

alias dpi='sudo dpkg -i'        # install .deb
alias dpp='sudo dpkg -P'        # purge .deb

alias dpl='dpkg-query -l'       # list pkg summary
alias dpL='dpkg-query -L'       # list pkg contents

# add GPG key for debian-repo
# usage: addkey 0x5017d4931d0acade295b68adfc6d7d9d009ed615
function addkey ()
{
    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com "$1"
}

# view sources.list, or append new entry
# usage: addscr [source-entry]
function addsrc ()
{
    case "$#" in
        # when no argument is provided, view sources.list
        0)
        sudo vim /etc/apt/sources.list
        ;;
        # otherwise, append new entry
        *)
        echo -ne "\n$@\n"| sudo tee -a /etc/apt/sources.list  >/dev/null 2>&1
        ;;
    esac
}

# show package size in sorted order
function pac-size ()
{
    dpkg-query -W --showformat='${Installed-Size;20}\t${Package}\n' | sort -k1,1n | awk '{printf("%15.2f MB\t %s\n",$1/1024, $2)}'

}

function old-kernels ()
{
    dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d'
}

function old-kernels-purge ()
{
    dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get --yes purge

}

function old-pkg-purge ()
{
    sudo aptitude purge ~o
}
