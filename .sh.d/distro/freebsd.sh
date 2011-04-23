#!/bin/bash

function add ()
{
    sudo pkg_add -r "$*"
}

function purge ()
{
    sudo pkg_delete "$*"
}


function list ()
{
    pkg_info -L -x "$1"
}

function own()
{
    pkg_info -W "$1"
}

function meta ()
{
    pkg_info -x "$1"
}

function depends ()
{
    pkg_info -r "$1"

}

function rev-depends ()
{
    pkg_info -R "$1"
}


function all ()
{
    pkg_info
}



# quite like iotop under linux
function io ()
{
    top -m io -o total
}

