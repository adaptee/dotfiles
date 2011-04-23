#!/bin/sh

alias mp='mplayer -af volnorm'

# simple wrapper for invoking  mplayer nicely with framebuffer
# mpf stands for mplayer with framebuffer
function mpf()
{
    file="$@"

    # FIXME:
    #if scale is set to 1024:768(the ideal size), some pixels will remain on the screen side
    # after mplayer exit.
    mplayer -vo fbdev2 -fs -x 1024 -y 768 -vf scale=1024:768 -really-quiet "${file}" 2>&1 >/dev/null &

    # this is very important ;
    # clear the screen will make the display not interfered by console output
    fg ; clear
}

