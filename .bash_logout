# ~/.bash_logout: executed by bash(1) when login shell exits.

# when leaving the console clear the screen to increase privacy

if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

if [ -x "${HOME}/bin/pack_firefox.sh" ];then
    ${HOME}/bin/pack_firefox.sh backup
fi

