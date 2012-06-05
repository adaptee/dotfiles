#!/bin/sh

#---------------------------------------------------------------------------#
#                                   make alias                              #
#---------------------------------------------------------------------------#

alias conf='./configure'

alias mk='make'
alias mki='make install'
alias mkt='make test'
alias mkc='make clean'

alias cmk='cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=debugfull -DKDE4_BUILD_TESTS=TRUE ../'

# when make produce errors, open vim to view such errors
function Make ()
{
    command make "$@" |& tee make.errors || vim -q make.errors -c ":copen" ;
}
