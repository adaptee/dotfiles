#!/bin/sh

# recommend way of using which, quoted from the manpage
function which ()
{
    (alias; declare -f) | gwhich --tty-only --read-alias --read-functions --show-tilde --show-dot $@
}
#export which
