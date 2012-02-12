#!/bin/bash

alias rsmb='sudo /etc/rc.d/samba restart'

# pacman-color is more user-friendly
which pacman-color >& /dev/null &&  alias pacman='pacman-color'

# no boring confimration!
alias yaourt='yaourt --noconfirm'

# -s install depends ;
# -f overwrite already-built package
alias makepkg='makepkg -s -f --noconfirm'

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
        yaourt -S --noconfirm $@
    fi
}

# remove existing package
# [Example] purge firefox
function purge ()
{
    yaourt -Rs --noconfirm $@
}

function update ()
{
    yaourt -Syy
}

# official + AUR
function upgrade ()
{
    yaourt -Su
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

# list all packages identified as foreign(most from AUR)
function aur ()
{
    pacman -Qmq
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
        pacman -Ql ${pkgnames[@]}
    fi
}

# which package own the specified file?
# [Example] own /usr/bin/vim
function own ()
{
    # relative path is also OK, thanks to `readlink`
    pacman -Qo $(readlink -f "$1")
}

# search package by name
# [Example] search firefox
function search ()
{
    yaourt -Ss "$1"
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
        pacman -Qi $pkgname
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

