#!/bin/sh


# enable touchpad
function padon ()
{
    synclient TouchpadOff=0
}

# disable touchpad
function padoff ()
{
    synclient TouchpadOff=1
}
