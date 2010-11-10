#!/bin/bash

#---------------------------------------------------------------------------#
#                               Shell prompt                                #
#---------------------------------------------------------------------------#

# color name definitions ,which provide for better readability

# tput provides better portability for these colors definitions.
if  which tput &> /dev/null ;then

    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    BROWN=$(tput setaf 3)
    BLUE=$(tput setaf 4)
    PURPLE=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    GRAY=$(tput setaf 7)

    LIGHTGRAY=$(tput bold;tput setaf 0)
    BRIGHTRED=$(tput bold;tput setaf 1)
    BRIGHTGREEN=$(tput bold;tput setaf 2)
    BRIGHTYELLOW=$(tput bold;tput setaf 3)
    BRIGHTBLUE=$(tput bold;tput setaf 4)
    BRIGHTPURPLE=$(tput bold;tput setaf 5)
    BRIGHTCYAN=$(tput bold;tput setaf 6)
    WHITE=$(tput bold;tput setaf 7)

    NOCOLOR=$(tput sgr0)   # No Color

else

    # when tput is unavailable,fall back to hard-coded definition.
    BLACK='\e[0;30m'
    RED='\e[0;31m'
    GREEN='\e[0;32m'
    BROWN='\e[0;33m'
    BLUE='\e[0;34m'
    PURPLE='\e[0;35m'
    CYAN='\e[0;36m'
    GRAY='\e[0;37m'

    LIGHTGRAY='\e[01;30m'
    BRIGHTRED='\e[01;31m'
    BRIGHTGREEN='\e[01;32m'
    BRIGHTYELLOW='\e[01;33m'
    BRIGHTBLUE='\e[01;34m'
    BRIGHTPURPLE='\e[01;35m'
    BRIGHTCYAN='\e[01;36m'
    WHITE='\e[01;37m'

    NOCOLOR='\e[00m'
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1_CHROOT=${debian_chroot:+($debian_chroot)}

# when last command failed, show its exit code with highlight
PS1_EXITCODE='`a=$?;if [ $a -ne 0 ]; then echo -n -e "\['${BRIGHTRED}'\][$a]\['${NOCOLOR}'\]"; fi`'

# show history number for current command
#PS1_HISTNUMER='\['${BRIGHTCYAN}'\]''(\!)'

# highlight the uses name for root, so that they/you are more cautious.
if [[ "$UID" != "0" ]]
then
    PS1_USER='\['${BRIGHTGREEN}'\]''\u'
    PS1_SYMBOL='\['${NOCOLOR}'\]''$ '
else
    PS1_USER='\['${BRIGHTRED}'\]''\u'
    PS1_SYMBOL='\['${NOCOLOR}'\]''# '
fi

PS1_AT='\['${NOCOLOR}'\]''@'

# highlight the host part for ssh session.
if [ -z "$SSH_TTY" ]
then
    PS1_HOST='\['${BRIGHTGREEN}'\]''\h'
else
    PS1_HOST='\['${BRIGHTRED}'\]''\h'
fi

PS1_COLON='\['${BRIGHTGREEN}'\]'':'

# show current folder; only the last part, not full path
PS1_PWD='\['${BRIGHTBLUE}'\]''\W'

# show which git branch we are on
PS1_GIT_BRANCH='`b=$(parse_git_branch); if [ x"$b" != "x" ]; then echo -n -e "\['${BRIGHTYELLOW}'\]($b)\['${NOCOLOR}'\]"; fi`'

PS1="${PS1_CHROOT}${PS1_EXITCODE}${PS1_USER}${PS1_AT}${PS1_HOST}${PS1_COLON}${PS1_PWD}${PS1_GIT_BRANCH}${PS1_SYMBOL}"

case "$TERM" in
    xterm*|rxvt*)
    # 1).show dynamic window title, reflecting "who is in where now?"
    # 2).synchronize history between multiple shell sessions.
    PROMPT_COMMAND='echo -ne "\e]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"; history -a; history -n'
    ;;
    *)
    ;;
esac


# PS3 is used when encountering select statement.
PS3='Choose one option by number: '

# PS4 will be used when 'set -x' is set, for tracing purpose.
PS4='line $LINENO: '


#---------------------------------------------------------------------------#
#                               Bash options                                #
#---------------------------------------------------------------------------#

# check window size after each command and update LINES & COLUMNS if necessary
shopt -s checkwinsize

# enable auto-spelling-correction for argument given-to 'cd';
shopt -s cdspell

# allow 'cd' to use variable's value as its argument
shopt -s cdable_vars

# check a command found in hash-table does exist in system before executing
shopt -s checkhash

# when it is the only candidate, do not ignore it
shopt -u force_fignore

# append history list , but not overwrite
shopt -s histappend

# Include dot (.) files in the results of expansion
#shopt -s dotglob

# Enable extended pattern matching
#shopt -s extglob

#do path expansion in case-insensitive way
shopt -s nocaseglob

#return empty string if no matching is found
#shopt -s nullglob

# use Emacs-style in terminal-input
set -o emacs on

# I hate noise
set bell-style none

# list completion candidate immediately after pressing 'TAB'
set show-all-if-ambiguous on


#------------------------------history related------------------------------#

# enables both ignorespace and ignoredups
HISTCONTROL=ignoreboth

# print the time stamp associated with each history entry
HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "

# Remove size limitation on history file ( .bash_history) ;
# now your .bash_history won't be truncated any more!
# [Side effect]: huge-sized .bash_history may cause slow startup
# [Reference]: http://mywiki.wooledge.org/BashFAQ/088
unset HISTFILESIZE

# the running bash do not need to remember the whole history
HISTSIZE=50000

# do not record these commands
HISTIGNORE="pwd:l:ls:ll:la:history:rm"

#--------------------------------bash related---------------------------------#

CDPATH=".:..:~:~/audio:~/book:~/code:~/down:~/vbox:/media"

# ignore file with those suffix when performing filename-auto-completion
FIGNORE='.o:.bak:.tmp:.orig'


#-----------------------------------man & less--------------------------------#

# make less more friendly for non-text input files, see lesspipe(1)
#which lesspipe &>/dev/null && eval "$(lesspipe)"
#which lesspipe.sh &>/dev/null && eval "$(lesspipe.sh)"

# press 'V' to call-out VIM, even when less is used together with pipeline.
echo "V pipe $ vim - \n" > "/tmp/lesskey-${USER}"

# press 'S' to search the head of each section in the manpage
echo "S forw-search \^[A-Z][A-Z\ ]+$\r" >> "/tmp/lesskey-${USER}"

lesskey -o ~/.less "/tmp/lesskey-${USER}"

#---------------------------------------------------------------------------#
#                               auto completion                             #
#---------------------------------------------------------------------------#

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

Source "/etc/bash_completion"

if [ -x "$HOME/bin/chsdir" ] ; then
    Source "${PRIVATE_BASH_DIR}/chs_completion.bash"
fi

complete -o filenames -F _man m
complete -o filenames -F _man ma
complete -o filenames -F _man man2txt

complete -F _kill k
complete -F _kill k9
complete -F _killall ka
complete -F _killall ka9
complete -F _pgrep psg

complete -a -c -f type
complete -a -c -f tp
complete -a -c -f tpa

complete -a a
complete -c wh
complete -A helptopic  h

complete -v e
complete -e ee

complete -o filenames -F _find f
complete -o filenames -F _longopt g

complete -cf sudo

# only provide .Z .gz and .tgz file to gunzip
complete -A file -X '!*.@(Z|gz|tgz)' gunzip

#---------------------------------------------------------------------------#
#                               Misc                                        #
#---------------------------------------------------------------------------#

# enable autojump
Source /etc/profile.d/autojump.bash
