#!/bin/sh

#---------------------------------------------------------------------------#
#                                   make alias                              #
#---------------------------------------------------------------------------#

alias conf='./configure'

alias mk='make'
alias mks='make --silent'
alias mi='make install'
alias mt='make test'
alias mkc='make clean'


# when make produce errors, open vim to view such errors
function Make ()
{
    command make "$@" |& tee make.errors || vim -q make.errors -c ":copen" ;
}
