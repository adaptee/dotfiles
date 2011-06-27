#!/bin/bash

#---------------------------------------------------------------------------#
#                                 package management                        #
#---------------------------------------------------------------------------#

# installl new package
# [Example] add firefox
function add ()
{
    if echo "$1" | grep -E 'pkg\.tar\.(xz|gz)$'  2>&1 >/dev/null ; then
        # add from local archive
        sudo pacman -U $@
    else
        # add from online repo or AUR
        sudo yum -y install $@
    fi
}

# remove existing package
# [Example] purge firefox
function purge ()
{
    sudo yum remove $@
}

function update ()
{
    sudo yum check-update
}

# official + AUR
function upgrade ()
{
    sudo yum update
}

# plus all dev-version pacakges
function full-upgrade ()
{
    yaourt -Su --devel
}

# remove package cache
function clean()
{
    sudo pacman -Scc --noconfirm
}

# inspired by  gentoo
# list all exlicitly installed packages
function world ()
{
    rpm -qa
}

# list all installed packages
function all ()
{
    rpm -qa
}

# list all un-needed  packages
function orphan ()
{
    pacman -Qtdq
}

# list what are contained within specified package
# [Example] list firefox
# [Example] list firefox-i686.pkg.xz
function list ()
{
    if echo "$1" | grep -E 'pkg\.tar\.(xz|gz)$'  2>&1 >/dev/null ; then
        # list content of local archive
        local archivenames
        archivenames=( $(echo "$@" | tr '[A-Z]' '[a-x]') )
        pacman -Qpl ${archivenames[@]}
    else
        # list content of installed package
        local pkgnames
        pkgnames=( $(echo "$@" | tr '[A-Z]' '[a-x]') )
        rpm -ql ${pkgnames[@]}
    fi
}

# which package own the specified file?
# [Example] own /usr/bin/vim
function own ()
{
    # relative path is also OK, thanks to `readlink`
    rpm -qf $(readlink -f "$1")
}

# search package by name
# [Example] search firefox
function search ()
{
    yum search $@
}

# show the meta info of specified package
# [Example] meta firefox
# [Example] meta firefox-i686.pkg.xz
function meta ()
{
    if echo "$1" | grep -E 'pkg\.tar\.(xz|gz)$'  2>&1 >/dev/null ; then
        # get info from local  archive
        local archivename="$@"
        pacman -Qpi $archivename
    else
        # get info from pacman database
        local pkgname
        pkgname=$(echo "$@" | tr '[A-Z]' '[a-x]')
        rpm -qi $pkgname
    fi
}

# only the the version of that package
function version()
{
    pacman -Q "$1"
}

# mark packages as explicited installed
function explicit ()
{
    sudo pacman -D --asexplicit --noconfirm $@
}

# find out which (installed) package own the command
function owncmd()
{
    local cmdname=$1
    local cmdpath=$(command which ${cmdname} 2>/dev/null)

    if [[  "${cmdpath}" == ""  ]] ; then
        echo "command [$cmdname] does not exist!"
    else
        own ${cmdpath}
    fi
}


# list package installed from aur( not within repo)
function aurs()
{
    pacman -Qmq

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

