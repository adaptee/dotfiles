# ~/.bashrc: executed by bash(1) for non-login interacvive-shells.

# If not running interactively, do nothing
[ -z "$PS1" ] && return

# source specified file, only when it really exist.
Source ()
{
    local item="$1"

    if [ -f "${item}" ] ; then
        source "${item}"
    else
        :
    fi
}

export PRIVATE_SHELL_DIR=$HOME/.sh.d
export PRIVATE_BASH_DIR=$HOME/.bash.d

for item in $PRIVATE_SHELL_DIR/*.sh ; do
    Source "${item}"
done

distro=$(distro-detect)
Source "${PRIVATE_SHELL_DIR}/distro/${distro}.sh"

Source "$PRIVATE_SHELL_DIR/test.sh"

# now comes bash-specific settings
Source "$PRIVATE_BASH_DIR/bash.bash"
Source "$PRIVATE_BASH_DIR/test.bash"
