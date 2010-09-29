#!/bin/bash
#===============================================================================
#
#          FILE:  gentoo.sh
#
#         USAGE:  ./gentoo.sh
#
#   DESCRIPTION:
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  adaptee (), adaptee@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  09/16/10 13:18:46 CST
#      REVISION:  ---
#===============================================================================


#---------------------------------------------------------------------------#
#                                 package management                        #
#---------------------------------------------------------------------------#

# installl new package
# [Example] add firefox
function add ()
{
    sudo emerge -av --keep-going "$@"
}

# remove existing package
# [Example] purge firefox
function purge ()
{
    sudo emerge -av --unmerge "$@"
}

function update ()
{
    sudo emerge --sync
    sudo layman -S
}

function upgrade ()
{
    sudo emerge -uavDN --keep-going world

}

function clean ()
{
    sudo emerge -av --depclean

}

# list all installed packages
function world ()
{
    cat /var/lib/portage/world
}

# add package into 'world
function explicit()
{
    sudo emerge --noreplace "$1"
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
    equery files "$1"
}

# which package own the specified file?
# [Example] own /usr/bin/vim
function own ()
{
    equery belongs "$1"
}

# search package by name
# [Example] search firefox
function search ()
{
    emerge --search "$1"
    #emerge --searchdesc "$1"
}

# show the meta info of specified package
# [Example] meta firefox
function meta ()
{
    equery depends "$1"
}

# show the USE flags of some package
# [Example] use firefox
function use ()
{
    equery uses "$1"
}

# search packages which use specific USE flags
# [Example] use qt4
function hasuse ()
{
    equery hasuse "$1"
}


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
#                                       Misc                                #
#---------------------------------------------------------------------------#




