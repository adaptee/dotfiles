#!/bin/sh

export EDITOR=$(command which vim 2>/dev/null)
export VISUAL=$EDITOR
export FCEDIT=$EDITOR


export PAGER="less"
export BROWSER="$PAGER"

# colorful man page
export LESS='--ignore-case --squeeze-blank-lines --LONG-PROMPT --RAW-CONTROL-CHARS '
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;32m'
export LESS_TERMCAP_ue=$'\e[01;34m'
export LESS_TERMCAP_us=$'\e[01;35m'

# Ignore binary files
# recursive by default
# highlight found target in results
export GREP_OPTIONS="--binary-files=without-match --directories=recurse --color=auto"
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"

export CTAGS='--c-kinds=+x --c++-kinds=+x --fields=+aiSt --extra=+q'

# for reference:
# http://udrepper.livejournal.com/11429.html
# http://www.pixelbeat.org/settings/.bashrc
# enable the auto init & clear feature of malloc() and free() in glibc
#export MALLOC_CHECK_=3
#export MALLOC_PERTURB_=$(($RANDOM % 255 + 1))


# allow wtf to use personal acronym database
export ACRONYMDB=$(echo "$HOME/.acronymdb")





