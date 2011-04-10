#!/bin/sh

# enable color support of ls(LS_COLORS)
if [[ "$TERM" != "dumb" ]] ; then
    if [[ -f ~/.dircolors ]] ; then
        eval $(dircolors ~/.dircolors)
    else
        eval $(dircolors )
    fi

    #  -X     sort alphabetically by entry extension
    alias ls='ls -X --group-directories-first --color=auto'
else
    alias ls='ls -X --group-directories-first'
fi

# 'F' means show trailing handy hints of the entry type
alias l='ls -F'
# 'A' means show hidden items. but excluding . and ..
alias la='l -A'

# '-1' means one file per line
alias l1='l -1'

# show detailed info
# show time in the format of yyyy-mm-dd
alias ll='l -hl --time-style=long-iso'
alias lla='ll -A'

# only list sub-directory under current directory
alias lf='ll -d */'

# In case you type 'ls' as 'sl'....
alias sl='ls'

## find most-recently modified file under current folder; sub-folder not considered.
alias latest='ll -t * | head -1'

## list file by size in descending order; sub-folder not considered.
alias bigfile='ll -S| head -3'
