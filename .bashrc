# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, do nothing
[ -z "$PS1" ] && return

#---------------------------------------------------------------------------#
#                               Shell prompt                                #
#---------------------------------------------------------------------------#

# PS4 is for debugging's purpose
export PS4='line $LINENO: '

# color defintions for better readability

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
PS1_EXITCODE='`a=$?;if [ $a -ne 0 ]; then echo -n -e "\['${BRIGHTRED}'\][$a]\['${NOCOLOR}'\]"; fi`'
#PS1_HISTNUMER='\['${BRIGHTCYAN}'\]''(\!)'

# hint for root user.
if [[ "$UID" != "0" ]]
then
    PS1_USER='\['${BRIGHTGREEN}'\]''\u'
    PS1_SYMBOL='\['${NOCOLOR}'\]''$ '
else
    PS1_USER='\['${BRIGHTRED}'\]''\u'
    PS1_SYMBOL='\['${NOCOLOR}'\]''# '
fi

PS1_AT='\['${NOCOLOR}'\]''@'

# hint for ssh session.
if [ -z "$SSH_TTY" ]
then
    PS1_HOST='\['${BRIGHTGREEN}'\]''\h'
else
    PS1_HOST='\['${BRIGHTRED}'\]''\h'
fi

PS1_COLON='\['${BRIGHTGREEN}'\]'':'
PS1_PWD='\['${BRIGHTBLUE}'\]''\W'

PS1_GIT_BRANCH='`b=$(parse_git_branch); if [ x"$b" != "x" ]; then echo -n -e "\['${BRIGHTYELLOW}'\]($b)\['${NOCOLOR}'\]"; fi`'

# fix-me:if PS1 is defined & exported in .profile, things just don't work
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

# check the window size after each command and update  LINES and COLUMNS if necessary
shopt -s checkwinsize

#enable spelling-auto-correction for the name in cmd of 'cd';
shopt -s cdspell

# enable cd use variable as its argument
shopt -s cdable_vars

# for safety's sake
shopt -s checkhash

# when it is the only candidate, do not ignore it
shopt -u force_fignore

#append,not overwrite
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

#---------------------------------------------------------------------------#
#                               Bash variables                              #
#---------------------------------------------------------------------------#

# colorful man page
# fix-me: if this fraction is put in .profile, man & less will not work as expected
# that's weired and should not happen

export PAGER="$(which less) -s -M " #-M "
export LESS=' -i -R ' 
export BROWSER="$PAGER"
export LESS_TERMCAP_mb=$'\e[01;31m'
export LESS_TERMCAP_md=$'\e[01;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;44;32m'
export LESS_TERMCAP_ue=$'\e[01;34m'
export LESS_TERMCAP_us=$'\e[01;35m'

# make less more friendly for non-text input files, see lesspipe(1)
which lesspipe &>/dev/null && [ -x lesspipe ] && eval "$(lesspipe)" 
which lesspipe.sh &>/dev/null && [ -x lesspipe.sh ] && eval "$(lesspipe.sh)" 

# press "v" to call-out VIM, even when less is used together with pipeline.
echo "v pipe $ vim - \n" > "/tmp/lesskey-${USER}"
lesskey -o ~/.less "/tmp/lesskey-${USER}"

#---------------------------------------------------------------------------------------------------

if [ -f ~/.bash.d/alias.sh ];then
    source ~/.bash.d/alias.sh
fi

#---------------------------------------------------------------------------#
#                               shell functions                             #
#---------------------------------------------------------------------------#

# source specified file, only when it really exist.
Source ()
{
    local item

    for item in "$@" ; do
        if [ -f "${item}" ] ; then
            source "${item}"
        else
            bcho "[error] file '${item}' does not exist."
        fi
    done
}

# grep your history!
# Usage: hg KEY_WORD
hg()
{ 
    history | grep -i $* | sort -k 2 | uniq -s 7 | sort -g | more;
}

hi()
{ 
    if [ "$1" -lt "30"  ];then    
        history $1
    else
        history $1 | less
    fi
}

hh()
{ 
    history 10;
}

topN() { history | awk '{a[$'`echo "1 2 $HISTTIMEFORMAT" | wc -w`']++}END{for(i in a){print a[i] "\t" i}}' | sort -rn | head -20; }


cd2iso()
{
    isofile=$1;
    readom dev=/dev/cdrom f=$isofile
}

# Often the next command after 'cd' is 'ls', so why not combine them into one? 
# Usage: cd PATH
cd() { builtin cd "${@:-$HOME}" && ls; }


# Colorize follwoing text
# Usage: green hello
green() { echo -e "${BRIGHTGREEN}$@${NOCOLOR}"; }
red()   { echo -e "${BRIGHTRED}$@${BRIGHTRED}"; }


# Ease the echoing of normal shell variables
# here we use the indirect refence format: ${!env_var}
# Usage: e shell_var_name...
e() 
{
    local item

    for item in "$@";do
        builtin echo "${!item}";
    done
}  


# Ease the echoing of environment variables
# here we use the indirect refence format: ${!env_var}
# Usage: ee env_var_name...
ee() 
{
    local item

    for item in "$@";do
        env_var=$(echo "$item" |tr '[a-z]' '[A-Z]'); 
        builtin echo "${!env_var}";
    done
}  


#---------------------------------------------------------------
# gnome utilily
#---------------------------------------------------------------

# Open specified files in apporiate programs
# Usage: go FILES...
go ()
{
    local item
    for item in "$@";do
        echo ${item}
        gnome-open ${item}
    done
}

# Simplify the usage of nautilus
# Usage naut [start-path]
naut()
{
    nautilus "${@:-$PWD}"
}


#---------------------------------------------------------------
# APT utilily
#---------------------------------------------------------------

purge2()
{
    dpkg -l|grep '^rc' | awk '{print $2}' | xargs sudo apt-get -y purge
}


# add new GPG key for apt-repo.
# Usage: addkey 0x5017d4931d0acade295b68adfc6d7d9d009ed615
addkey()
{
    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com $1
}

# View or append new entry into sources.list
# Usage: addscr [source-entry]
addsrc()
{
    case "$#" in
        0)
        sudo vim /etc/apt/sources.list
        ;;
        1)
        echo -ne "\n$1\n"| sudo tee -a /etc/apt/sources.list  >/dev/null 2>&1
        ;;
    esac
}

#---------------------------------------------------------------------------#
#                               Converting utilily                          #
#---------------------------------------------------------------------------#

# Convert one single pdf file to multiple png files,one png file correspond to one page
# Usage: pdf2png xxxx.pdf
pdf2png()
{
    convert -quality 100 -antialias -density 96 -transparent white -trim $1 $( basename $1 '.pdf')".png"
}

# transform manual to pure text file
# Usage: man2txt command... 
man2txt()
{
    local item
    for item in "$@";do
        man ${item} | col -b >"${item}.txt" 
    done
}


# Tranform text from gb* encoding to utf-8; old file is automatically renamed
# Usage: gb2u8  gbk-encoded.txt...
gb2u8()
{
    local item
    for item in "$@";do
        if  enca "${item}" | grep -i 'GB2312\|Unrecognize' >/dev/null  ; then
            iconv -f gb18030  -t utf8 -c "${item}" > "${item}.new"  &&  mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"    
            echo "${item} is converted into utf-8 encoding"
        fi
    done
}

# Tranform text from utf-8 encoding to gb*; old file is automatically renamed
# Usage: u82gb  gbk-encoded.txt...
u82gb()
{
    local item

    for item in "$@";do
        if echo $(enca "${item}" ) | grep -i "UTF-8" >/dev/null ; then
            iconv -f utf8 -t gb18030  -c "${item}" > "${item}.new"  &&  mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"    
            echo "${item} is converted into gbk encoding."
        fi
    done

}

# Tranform text from utf-16 encoding to utf-8; old file is automatically renamed
# Usage: u162u8  gbk-encoded.txt...
u162u8()
{
    local item

    for item in "$@";do
        if echo $(enca "${item}" ) | grep -i "UCS-2" >/dev/null ; then
            iconv -f utf16 -t utf8  -c "${item}" > "${item}.new"  &&  mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"    
            echo "${item} is converted into utf-16 encoding."
        fi
    done

}
# Adjust the indentation of xml files in place 
# Usage: indentxml xml_file_1 xml_file_2 ... xml_file_N
indentxml ()
{
    local item
    for item in "$@";do
        tidy -xml -i -m $item
    done
}


# convert filename to UTF-8 encoding
# Usage convmv_utf8 FILES....
convmv_utf8 ()
{
    convmv -f gbk -t utf-8 --notest "$@"
}


# Empty specified files
# Usage: null file1 file2 ... fileN
null ()
{
    local item
    for item in "$@";do
        cat /dev/null > $item
    done
}


# share folder throuth http://localhost:8000 
# Usage: share FOLDER-PATH
share()
{
    builtin cd "${@:-$PWD}"
    python -m SimpleHTTPServer &
}

# get blacklist from authority and generate the needed command to block these suspicious ip
# Usage: blacklist
blacklist()
{
    wget -qO - http://infiltrated.net/blacklisted|awk '!/#|[a-z]/&&/./{print "iptables -A INPUT -s "$1" -j DROP"}'
}

# Generate random string with specified length
# Usage: randomstr N
randomstr()
{
    strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n';
}

# search for files containing specified pattern recursively, starting from current folder 
#Usage:
#   grep_for  [pattern] 
#   grep_for  [pattern] [suffix_filter]
#Example:
#   grep_for include \.txt
grep_for() 
{
    local content=$1

    if [ -z "$2" ]
    then
        shift
    else
        local flag=`echo $2 | sed 's/^\(.\).*$/\1/'`
        if [ "$flag" == "-" ]
        then
            shift
        else
            local filter=$2
            shift
            shift
        fi  
    fi  

    if [ -z "$filter" ]
    then
        find -print0 | grep -zv '\.svn' | xargs -0 grep --color $content $@
    else
        find -print0 | grep -zv '\.svn' | grep -z $filter | xargs -0 grep --color $content $@
    fi  
} 

# Delelte all mails in the mailbox
# Usage: clearmail()
clearmail ()
{
    echo 'd *' | mail -N
}

# shows the git history as ASCII graph
glog() 
{
    git log --pretty=oneline --topo-order --graph --abbrev-commit $@
}

# show current folder's git branch info
parse_git_branch() 
{
    # tell 'cut' to use SPACE as delimiter
    git branch 2> /dev/null | sed -e '/^[^*]/d' | cut --delimiter=\  --fields=2
}

#---------------------------------------------------------------------------#
#                               auto completion                             #
#---------------------------------------------------------------------------#

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

if [ -f ~/.bash.d/chs_completion.sh ]; then
    source ~/.bash.d/chs_completion.sh
fi

if [ -f ~/.bash.d/cdargs-bash.sh ];then
    source ~/.bash.d/cdargs-bash.sh
fi


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


