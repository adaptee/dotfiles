#!/bin/sh

#---------------------------------------------------------------------------#
#                                 Grep quickly                              #
#---------------------------------------------------------------------------#

alias egrep='egrep -I --color=auto'

# '-I' means returning no match for any binary file
alias g='grep -I --color=auto'

alias gi='g -i'
alias gl='g -l'
alias gn='g -n'
alias gr='g -r'
alias gv='g -v'
