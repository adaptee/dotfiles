# ~/.bash_logout: executed by bash(1) when login shell exits.

# backup firefox profile
if [ -x "${HOME}/bin/pack_firefox.sh" ];then
    ${HOME}/bin/pack_firefox.sh backup
fi

# when leaving the console clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ "$PS1" ] && clear
fi


