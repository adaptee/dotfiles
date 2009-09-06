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
    PATH="$HOME/bin:$PATH"
fi

# input method
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

#------------------------------------------------------------------------------
#                                 load bashrc                                 #
#------------------------------------------------------------------------------

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

#------------------------------------------------------------------------------
#                           restore firefox profile.                          #
#------------------------------------------------------------------------------
# 
if [ -x "${HOME}/bin/pack_firefox.sh" ];then
    ${HOME}/bin/pack_firefox.sh &
fi


#------------------------------------------------------------------------------
#                                   SSH keyring                               #
#------------------------------------------------------------------------------

eval $(ssh-agent)

SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"

if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "kill $SSH_AGENT_PID" 0
fi

ssh-add




