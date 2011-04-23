#!/bin/sh

# only consider binary existing in the FS; no funtions nor aliases
function bin-exist()
{
    if command which $1 >/dev/null 2>/dev/null ; then
        return 0
    else
        return 1
    fi

}

# this one considers functions and aliases
function cmd-exist()
{
    if which $1 >/dev/null 2>/dev/null ; then
        return 0
    else
        return 1
    fi
}

# typing " file `which xxx` " is a bit long and annoying
function flcmd ()
{
    if bin-exist "$1" ; then
        file $(command which "$1")
    fi
}

# typing " vi `which xxx` " is a bit long and annoying
function vicmd ()
{
    if bin-exist "$1" ; then
        vim $(command which "$1")
    fi
}

# typing " ls -l `which xxx` " is a bit long and annoying
function llcmd ()
{
    if bin-exist "$1" ; then
        ls -l $(command which "$1")
    fi
}

# typing " ldd `which xxx` " is a bit long and annoying
function lddcmd ()
{
    if bin-exist "$1" ; then
        ldd $(command which "$1")
    fi
}

