#!/bin/bash

#---------------------------------------------------------------------------#
#                               Shell prompt                                #
#---------------------------------------------------------------------------#

# PS4 wiil be used when 'set -x' is executed, for tracing purpose.
export PS4='line $LINENO: '

# color name defintions ,which provide for better readability

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

    # when tput is unavailabe,fall back to hard-coded definition.
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

PS1="${PS1_CHROOT}${PS1_EXITCODE}${PS1_HISTNUMER}${PS1_USER}${PS1_AT}${PS1_HOST}${PS1_COLON}${PS1_PWD}${PS1_GIT_BRANCH}${PS1_SYMBOL}" 

# show dynamic window title, reflecting "who is in where now?"
case "$TERM" in
    xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\e]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007";history -a'
    ;;
    *)
    ;;
esac

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
shopt -s nullglob

# use emacs-style in terminal-input
set -o emacs on

# Let me have core dumps
ulimit -c unlimited

# I hate noise
set bell-style none

#---------------------------------------------------------------------------#
#                       Environment Variables                               #
#---------------------------------------------------------------------------#

#------------------------------history related------------------------------#

# enables both ignorespace and ignoredups
export HISTCONTROL=ignoreboth

# print the time stamp associated with each history entry 
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
 
export HISTFILESIZE=50000
export HISTSIZE=50000

# do not record these commands
export HISTIGNORE="pwd:l:ls:ls -ltr"

#--------------------------------grep related-------------------------------#

# Ignore binary files
# recurse by default
# highlight target keyword in results
export GREP_OPTIONS="--binary-files=without-match --directories=recurse --color=auto"
export GREP_COLORS="ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36"

#--------------------------------bash related---------------------------------#
export CDPATH=".:..:~:~/prog/EBook/:~/Desktop/:~/video/"
# ignore file with those suffix when perforaming filename-auto-completion
export FIGNORE='.o:.bak:.tmp:.orig'

#-----------------------------------development-------------------------------#

# for reference: 
# http://udrepper.livejournal.com/11429.html
# http://www.pixelbeat.org/settings/.bashrc
# enbale the auto init & clear feature of malloc() and free() in glibc
#export MALLOC_CHECK_=3
#export MALLOC_PERTURB_=$(($RANDOM % 255 + 1))
                                                                                  


#-----------------------------------vim related-------------------------------#
export EDITOR=$(which vim)
export FCEDIT=$(which vim)
export CTAGS='--c-kinds=+x --c++-kinds=+x --fields=+aiSt --extra=+q'


#-----------------------------------man & less--------------------------------#

# colorful man page

export PAGER="less" 
export LESS='--ignore-case --squeeze-blank-lines --LONG-PROMPT --RAW-CONTROL-CHARS ' 
export BROWSER="$PAGER"
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;32m'
export LESS_TERMCAP_ue=$'\e[01;34m'
export LESS_TERMCAP_us=$'\e[01;35m'

# make less more friendly for non-text input files, see lesspipe(1)
which lesspipe &>/dev/null && eval "$(lesspipe)" 
which lesspipe.sh &>/dev/null && eval "$(lesspipe.sh)" 

# press "v" to call-out VIM, even when less is used together with pipeline.
echo "v pipe $ vim - \n" > "/tmp/lesskey-${USER}"
lesskey -o ~/.less "/tmp/lesskey-${USER}"

#---------------------------------------------------------------------------#
#                               auto completion                             #
#---------------------------------------------------------------------------#

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).

Source "/etc/bash_completion"

if [ -x "$HOME/bin/chsdir" ] ; then
    Source "${PRIVATE_BASH_DIR}/chs_completion.sh"
fi

Source "${PRIVATE_BASH_DIR}/cdargs-bash.sh"

complete -c sudo
complete -c s

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

#complete -o filenames -F _dpkg dpi
#complete -o filenames -F _dpkg dpp
#complete -o filenames -F _dpkg dps
#complete -o filenames -F _dpkg dpS
#complete -o filenames -F _dpkg dpl
#complete -o filenames -F _dpkg dpL

