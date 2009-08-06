# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile
#umask 022

#echo "PID:$$" >> ${HOME}/log-bash
#echo ".profle is source!" >> ${HOME}/log-bash

#---------------------------------------------------------------------------------------------
# environment variables
#---------------------------------------------------------------------------------------------

# input method
export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus

#------ history related-------#

# enables both ignorespace and ignoredups
export HISTCONTROL=ignoreboth

#print the time stamp associated with each history entry 
export HISTTIMEFORMAT="%F %T "

export HISTFILESIZE=50000
export HISTSIZE=50000

#Do not record these commands
export HISTIGNORE="pwd:l:ls:ls -ltr"

#------ grep related-------#

#Ignore binary files
#recurse by default
#highlight target keyword in grep results
export GREP_OPTIONS="--binary-files=without-match --directories=recurse --color=auto"
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"

#------bash related-------#
export CDPATH=".:..:~:~/prog/EBook/:~/Desktop/:~/video/"
export EDITOR=$(which vim)
export FCEDIT=$(which vim)
# ignore file with those suffix when perforaming filename-auto-completion
export   FIGNORE='.o:.bak:.tmp:.orig'

#------vim related------#
export CTAGS='--c-kinds=+x --c++-kinds=+x --fields=+aiSt --extra=+q'

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

#eval $(ssh-agent)
SSHAGENT=/usr/bin/ssh-agent
SSHAGENTARGS="-s"

if [ -z "$SSH_AUTH_SOCK" -a -x "$SSHAGENT" ]; then
    eval `$SSHAGENT $SSHAGENTARGS`
    trap "kill $SSH_AGENT_PID" 0
fi

~/bin/pack_firefox.sh &

ssh-add

#---------------------------------------------------------------------------------------------
# read .bashrc
#---------------------------------------------------------------------------------------------

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

