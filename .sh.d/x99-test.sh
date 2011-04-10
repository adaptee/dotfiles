#!/bin/sh

# This is a place for temporary testing purpose
# remember to clear the staff here, at times !

# better color support
# I believe all xterm support 256 colors nowadays
if [[ $TERM =~ 'xterm' ]] ; then
    export TERM='xterm-256color'
fi

function fakemac ()
{
    sudo ifconfig wlan0 down
    #sudo ifconfig wlan0 hw ether '00:50:da:8b:74:15'    # for 192.168.1.10
    sudo ifconfig wlan0 hw ether '00:13:02:03:f5:c7'     # for 192.168.1.14
    sudo ifconfig wlan0 up

}

function origmac ()
{
    sudo ifconfig wlan0 down
    sudo ifconfig wlan0 hw ether '00:1f:3c:48:47:86'
    sudo ifconfig wlan0 up

}

function pac-size2 ()
{

    LC_ALL=C pacman -Qi | sed -n '/^Name[^:]*: \(.*\)/{s//\1 /;x};/^Installed[^:]*: \(.*\)/{s//\1/;H;x;s/\n//;p}' | sort -nk2

}

#export XMODIFIERS="@im=fcitx"
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx


# ask wingide to respect system sytel of gtk
alias wingide='wingide --system-gtk'

# sbcl do not support readline natively, so ...
alias sbcl='rlwrap sbcl'

# now you can 'man os.path.relpath'
function man
{
    ( LANG=en /usr/bin/man "$@" || pydoc "$1" ||
    echo "No manual entry or python module for $1") 2>/dev/null
}

# open source code of specified module in vim
function vipy()
{
    vim  $(python -c \
            "import $1; \
             module_path = $1.__file__; \
             module_path = module_path[:-1] if module_path[-1] == 'c' else module_path; \
             print(module_path); \
            "
          )
}


alias origin='cat .git/config | grep -i url'

function lfs()
{
    sudo mv -v "$1" /mnt/lfs/@build
}

function grub-update()
{
    sudo grub-mkconfig -o /boot/grub/grub.cfg
}

# This allow you to run `sudo ll`
# http://www.shellperson.net/using-sudo-with-an-alias/
#alias sudo='sudo '
