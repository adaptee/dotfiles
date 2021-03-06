# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, do nothing
[ -z "$PS1" ] && return

# source specified file, only when it really exist.
Source ()
{
    local item

    for item in "$@" ; do
        if [ -f "${item}" ] ; then
            source "${item}"
        else
            :
            #echo "[error] file '${item}' does not exist."
        fi
    done
}

export PRIVATE_BASH_DIR=$HOME/.bash.d

Source "$PRIVATE_BASH_DIR/alias.sh"
Source "$PRIVATE_BASH_DIR/function.sh"
Source "$PRIVATE_BASH_DIR/common.sh"

if [[ $(uname) =~ 'Linux'  ]] ; then

    distro=$(distro-detect)

    if [[ ${distro} != "unknown"  ]] ; then
        Source "${PRIVATE_BASH_DIR}/${distro}.sh"
    fi

elif [[ $(uname) =~ 'Cygwin' ]] ; then
    Source "$PRIVATE_BASH_DIR/cygwin.sh"
fi

Source "$PRIVATE_BASH_DIR/test.sh"
