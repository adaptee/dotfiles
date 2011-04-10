#!/bin/sh

# Ignore binary files
# recursive by default
# highlight matching
export GREP_OPTIONS="--binary-files=without-match --directories=recurse --color=auto"
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"


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
