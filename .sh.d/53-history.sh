#!/bin/sh

#---------------------------------------------------------------------------#
#                               history related                             #
#---------------------------------------------------------------------------#

# grep your history!
# usage: hgrep KEY_WORD
function hgrep ()
{
    # sorted and uniqed.
    history | grep -i "$*" | sort -k 2 | uniq -s 7 | sort -g | grep -i "$*"

    # raw history list
    #history | grep -i "$*"
}

# list your history
# usage: hlist [recent-number]
function hlist ()
{
    if [ "$1" -lt "30"  ];then
        history "$1"
    else
        history "$1" | less
    fi
}

# list last ten commands
# usage: hh
function hh ()
{
    history 10;
}

