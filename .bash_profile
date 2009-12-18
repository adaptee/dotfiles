# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is already set in /etc/profile
#umask 022

#------------------------------------------------------------------------------
#                           environment variables                             #
#------------------------------------------------------------------------------

# set PATH to include user's private bin ,if it exists
if [ -d "${HOME}/bin" ] ; then
    PATH="${PATH}:${HOME}/bin"
fi

# input method
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

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
#                           restore firefox profile.                          #
#------------------------------------------------------------------------------
#
if [ -x "${HOME}/bin/pack-firefox.sh" ];then
    ${HOME}/bin/pack-firefox.sh restore &
fi

#------------------------------------------------------------------------------
#                               start gappproxy client                        #
#------------------------------------------------------------------------------

~/bin/gappproxy

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
    trap " kill ${SSH_AGENT_PID} " 0
fi

# prompt user to add private key
#ssh-add

