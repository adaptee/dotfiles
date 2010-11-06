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

export PRIVATE_SHELL_DIR=$HOME/.sh.d
export PRIVATE_BASH_DIR=$HOME/.bash.d

Source "$PRIVATE_SHELL_DIR/alias.sh"
Source "$PRIVATE_SHELL_DIR/function.sh"


if [[ $(uname) =~ 'Linux'  ]] ; then

    distro=$(distro-detect)

    if [[ ${distro} != "unknown"  ]] ; then
        Source "${PRIVATE_SHELL_DIR}/${distro}.sh"
    fi

elif [[ $(uname) =~ 'Cygwin' ]] ; then
    Source "$PRIVATE_SHELL_DIR/cygwin.sh"
fi

Source "$PRIVATE_BASH_DIR/bash.bash"

Source "$PRIVATE_SHELL_DIR/test.sh"
Source "$PRIVATE_BASH_DIR/test.bash"

