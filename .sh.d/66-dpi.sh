#!/bin/sh

# query the native dpi calculated by Xorg
function dpi-xorg ()
{
    xdpyinfo | grep 'dots'
}

# query the physical parameter of the screen
function pixels ()
{
    xdpyinfo | grep dimensions
}

# query the dpi used by fontconfig
# 
# Fontconfig will default to the Xft.dpi variable if it is set. Xft.dpi is
# usually set by desktop environments (usually to Xorg's DPI setting) or
# manually in ~/.Xdefaults or ~/.Xresources :
#
#  Xft.dpi: 96.0
function dpi-fontconfig ()
{
    xrdb -query | grep dpi
}
