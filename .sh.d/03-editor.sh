#!/bin/sh

# I am a Vimmer, so use vim anywhere !
export EDITOR=$(command which vim 2>/dev/null)
export VISUAL="$EDITOR"
export FCEDIT="$EDITOR"
