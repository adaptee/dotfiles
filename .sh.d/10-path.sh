#!/bin/sh

# include user's bin into PATH ,if it exists
if [ -d "${HOME}/bin" ] ; then
    export PATH="${PATH}:${HOME}/bin"
fi
