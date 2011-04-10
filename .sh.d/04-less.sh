#!/bin/sh

export PAGER="less"
export BROWSER="$PAGER"

# --shift : how much to scrool horizontally when pressing <Left>/<Right> arrow
export LESS='--ignore-case --squeeze-blank-lines --LONG-PROMPT --RAW-CONTROL-CHARS --shift 5 '

# make man-pages colorful
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;32m'
export LESS_TERMCAP_ue=$'\e[01;34m'
export LESS_TERMCAP_us=$'\e[01;35m'

# default charset/encoding for less
export LESSCHARSET=utf-8

