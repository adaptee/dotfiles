# ~/.bashrc: executed by bash(1) for non-login interacvive-shells.

# If not running interactively, do nothing
[ -z "$PS1" ] && return

# source specified file in a safe way.
Source ()
{
    local item="$1"

    if [ -f "${item}" ] ; then
        source "${item}"
    else
        true
    fi
}

# common stuff for all shells
export PRIVATE_SHELL_DIR=$HOME/.sh.d
distro=$(distro-detect)
Source "${PRIVATE_SHELL_DIR}/distro/${distro}.sh"

for item in $PRIVATE_SHELL_DIR/*.sh ; do
    Source "${item}"
done
Source "$PRIVATE_SHELL_DIR/test.sh"

# specific stuff for bash
export PRIVATE_BASH_DIR=$HOME/.bash.d
Source "$PRIVATE_BASH_DIR/bash.bash"
Source "$PRIVATE_BASH_DIR/test.bash"
