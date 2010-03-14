# ~/.profile: executed by the command interpreter for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.


#------------------------------------------------------------------------------
#                              basic setting                                  #
#------------------------------------------------------------------------------

# the default umask is already set in /etc/profile
umask 022

# disable terminal to show  the annoying '^C' after pressing <Ctrl-C>
stty -ctlecho

#------------------------------------------------------------------------------
#                           environment variables                             #
#------------------------------------------------------------------------------

# set PATH to include user's private bin ,if it exists
if [ -d "${HOME}/bin" ] ; then
    PATH="${PATH}:${HOME}/bin"
fi

# use ibus as input method anywhere
export GTK_IM_MODULE="ibus"
export QT_IM_MODULE="ibus"
export XMODIFIERS="@im=ibus"

# If under X window environment,
if [ -n "$DISPLAY" ]  ; then

    #grant root the access to X server
    xhost +local:root

    # start devilspie, a nice rule matcher based on window property
    if which devilspie ; then
        devilspie &
    fi

fi

#------------------------------------------------------------------------------
#                                 load bashrc                                 #
#------------------------------------------------------------------------------

# if running bash
if [ -n "${BASH_VERSION}" ]; then
    # include .bashrc if it exists
    if [ -f "${HOME}/.bashrc" ]; then
        source "${HOME}/.bashrc"
    fi
fi


#------------------------------------------------------------------------------
#                                   SSH keyring                               #
#------------------------------------------------------------------------------

SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"

if [ -z "${SSH_AUTH_SOCK}" -a -x "${SSHAGENT}" ]; then
    # now, all application within this session know how to communicate with
    # ssh-agent by enviroment variable $SSH_AGENT_PID
    eval `${SSHAGENT} ${SSHAGENTARGS}`

    # kill this session's ssh-agent before shell exits.
    trap "kill -9 ${SSH_AGENT_PID}" 0
fi

# prompt user to add private key
#ssh-add

#------------------------------------------------------------------------------
#                               start gappproxy client                        #
#------------------------------------------------------------------------------

if [ -x "${HOME}/bin/gappproxy" ];then
    ~/bin/gappproxy &
fi
