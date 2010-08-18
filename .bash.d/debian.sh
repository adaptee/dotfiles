#!/bin/bash
#===============================================================================
#
#          FILE:  ubuntu.sh
#
#         USAGE:  ./ubuntu.sh
#
#   DESCRIPTION:  ubuntu specific setting for bash
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  adaptee (), adaptee@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  05/07/10 14:01:56 CST
#      REVISION:  ---
#===============================================================================

alias rnet='sudo /etc/init.d/networking restart'
alias rsmb='sudo /etc/init.d/smbd restart'


#---------------------------------------------------------------------------#
#                                 package management                        #
#---------------------------------------------------------------------------#

# installl new package
# [Example] add firefox
function add ()
{
    sudo apt-get install --yes --force-yes  --auto-remove "$@"
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

# list all installed packages
function world ()
{
    dpkg-query -l
}

# list all availabe packages from the repos
function all ()
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
    apt-cache show "$1"
}

alias syn='sudo synaptic'

alias dpi='sudo dpkg -i'        # install .deb
alias dpp='sudo dpkg -P'        # purge .deb

alias dpl='dpkg-query -l'       # list pkg summary
alias dpL='dpkg-query -L'       # list pkg contents


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
    dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge

}

function old-pkg-purge ()
{
    sudo aptitude purge ~o
}
