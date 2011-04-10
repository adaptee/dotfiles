#!/bin/sh

# echo bash variables more easily
# here we use indirect reference format: ${!env_var}
# usage: e shell_var_name...
function e ()
{
    local item

    for item in "$@";do
        # indirect expansion
        eval echo "\$${item}"
    done
}


# echo environment variables more easily(lower-case input is OK)
# here we use indirect reference format: ${!env_var}
# usage: ee env_var_name...
function ee ()
{
    local item

    for item in "$@";do
        env_var=$(echo "${item}" |tr '[a-z]' '[A-Z]');
        # indirect expansion
        eval echo "\$${env_var}"
    done
}
