# ~/.zshrc: executed by zsh(1) for non-login interacvive-shells.

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
export PRIVATE_ZSH_DIR=$HOME/.zsh.d

#Source "$PRIVATE_SHELL_DIR/alias.sh"
#Source "$PRIVATE_SHELL_DIR/function.sh"

#if [[ $(uname) =~ 'Linux'  ]] ; then

    #distro=$(distro-detect)

    #if [[ ${distro} != "unknown"  ]] ; then
        #Source "${PRIVATE_SHELL_DIR}/${distro}.sh"
    #fi

#elif [[ $(uname) =~ 'Cygwin' ]] ; then
    #Source "$PRIVATE_SHELL_DIR/cygwin.sh"
#fi

for item in $PRIVATE_SHELL_DIR/*.sh ; do
    Source "${item}"
done

distro=$(distro-detect)
Source "${PRIVATE_SHELL_DIR}/distro/${distro}.sh"

Source "$PRIVATE_SHELL_DIR/test.sh"

# now comes zsh-specific settings
Source "$PRIVATE_ZSH_DIR/zsh.zsh"
Source "$PRIVATE_ZSH_DIR/test.zsh"


