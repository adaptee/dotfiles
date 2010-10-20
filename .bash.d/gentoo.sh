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


# gentoo's dafault does not contain /usr/sbin
# thus makeing ifconfig, lspci,etc unconvenient to use
export PATH="${PATH}:/usr/sbin:/sbin"

#---------------------------------------------------------------------------#
#                                 package management                        #
#---------------------------------------------------------------------------#

# installl new package
# [Example] add firefox
function add ()
{
    sudo emerge -av --tree --keep-going "$@"
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

# list all directly installed packages
function world ()
{
    cat /var/lib/portage/world
}

# list all installed packages, explictly or as dependency
function all()
{
    qlist -I
}

# add package into 'world
# [example] explicit ktorrent
function explicit()
{
    sudo emerge --noreplace "$1"
}

# list the contents of pkgs
# [Example] list firefox
function list ()
{
    qlist $@
    #equery files "$1"
}

# which package own the specified file?
# [Example] own /usr/bin/vim
function own ()
{
    qfile -e $@
    #equery belongs "$1"
}

# search package by name
# [Example] search firefox
function search ()
{
    eix $1
    #qsearch $1
    #emerge --search "$1"
}

# show the meta info of specified package
# [Example] meta firefox
function meta ()
{
    equery uses "$1"
}

# show the USE flags of some package
# [Example] use firefox
function use ()
{
    equery uses "$1"
    #qlist -U $@
}

# search packages which use specific USE flags
# [Example] use qt4
function hasuse ()
{
    equery hasuse "$1"
    #quse $@
}

# whom does <pkg> depends on?
# [example] depend amule
function depend()
{
    qdepends $1
    #equery depgraph --depth=1 $1
}

# who depends on <pkg>?
function rev-depend()
# [example] rev-depend amule
{
    qdepends -Q $1
    #equery depends $1
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

# Show average building time of specified packages
# The estimation is based upon emerge log
# [example] etime amule ktorrent
function etime()
{
    qlop -Ht $@
}

# show the merging history of specified pkg, or all pkgs
# [example] ehistory amule
function ehistory()
{
    qlop -l $@
}

# show the size of spcified installed packages(including direct dependency)
# [example] esize amule
function esize()
{
    qsize -m -s $@
}

# list packages which are multi-slot installed, such as python2/3
# [example] slot
function eslot ()
{
    qlist -D
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




