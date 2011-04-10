#!/bin/sh

# always run man with English locale, because I do not like
# translated version
function man ()
{
    LANG=en_US.utf-8 command man $*
}
