#!/bin/sh

# access vimdoc from cmdline
# [Example] vimhelp fileencoding
function vimhelp()
{
    # hint: remove all VimEnter related cutocmds
    vim -c "help $1" -c "only" -c "autocmd! VimEnter *"
}

# grep vimdoc from cmdline
# [Example] vimhelpgrep fileencoding
function vimhelpgrep()
{
    vim -c "helpgrep $1" -c "only" -c "copen" -c "autocmd! VimEnter *"
}
