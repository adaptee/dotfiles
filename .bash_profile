# ~/.profile: executed by the command interpreter for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.


#------------------------------------------------------------------------------
#                              basic setting                                  #
#------------------------------------------------------------------------------

# the default umask is already set in /etc/profile
umask 022


#------------------------------------------------------------------------------
#                           environment variables                             #
#------------------------------------------------------------------------------

# set PATH to include user's private bin ,if it exists
if [ -d "${HOME}/bin" ] ; then
    PATH="${PATH}:${HOME}/bin"
fi

# If under X window environment,
if [ -n "$DISPLAY" ]  ; then

    #grant root the access to X server
    xhost +local:root

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


# keychain is preferred, because the ssh-agent it start persists across login
# if keychain is not available, start ssh-agent in normal way
if which keychain &> /dev/null ; then
    eval $(keychain --agents ssh --eval id_rsa)
else

    SSHAGENT=/usr/bin/ssh-agent

    if [ -z "${SSH_AUTH_SOCK}" -a -x "${SSHAGENT}" ]; then
        # now, all application within this session know how to communicate with
        # ssh-agent by enviroment variable $SSH_AGENT_PID
        eval `${SSHAGENT} -s`

        # kill this session's ssh-agent before login-shell exits
        trap "kill -9 ${SSH_AGENT_PID}" 0
    fi

    # prompt user to load private key into ssh-agent
    #ssh-add

fi



#------------------------------------------------------------------------------
#                               start gappproxy client                        #
#------------------------------------------------------------------------------

if [ -x "${HOME}/bin/gappproxy" ];then
    ~/bin/gappproxy &
fi
