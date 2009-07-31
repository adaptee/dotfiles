# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, do nothing
[ -z "$PS1" ] && return

#---------------------------------------------------------------------------------------------
# Shell Prompt 
#---------------------------------------------------------------------------------------------

# for debugging's purpose
export PS4='line $LINENO: '

# fix-me:if PS1 is defined & exported in .profile, things just don't work

# Define Colors
# tput can provide better portability for these colors, so recommended.
if  which tput &> /dev/null ;then

    #---- use tput to imporve portability-----
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

    #------ if tput is unavailabe,fall back to hard-coded-----
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

    NOCOLOR='\e[00m'              #No Color
fi

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

PS1_CHROOT=${debian_chroot:+($debian_chroot)}
#PS1_EXITCODE='\['${BRIGHTYELLOW}'\]''[$?]'
PS1_EXITCODE='`a=$?;if [ $a -ne 0 ]; then echo -n -e "\['${BRIGHTRED}'\][$a]\['${NOCOLOR}'\]"; fi`'
#PS1_HISTNUMER='\['${BRIGHTCYAN}'\]''(\!)'

if [[ "$UID" != "0" ]]
then
    PS1_USER='\['${BRIGHTGREEN}'\]''\u'
    PS1_SYMBOL='\['${NOCOLOR}'\]''$ '
else
    PS1_USER='\['${BRIGHTRED}'\]''\u'
    PS1_SYMBOL='\['${NOCOLOR}'\]''# '
fi

PS1_AT='\['${NOCOLOR}'\]''@'

if [ -z "$SSH_TTY" ]
then
    PS1_HOST='\['${BRIGHTGREEN}'\]''\h'
else
    PS1_HOST='\['${BRIGHTRED}'\]''\h'
fi

PS1_COLON='\['${BRIGHTGREEN}'\]'':'
PS1_PWD='\['${BRIGHTBLUE}'\]''\W'

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

#---------------------------------------------------------------------------------------------
# bash options
#---------------------------------------------------------------------------------------------

# check the window size after each command and, if necessary and update the values of LINES and COLUMNS.
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

#---------------------------------------------------------------------------------------------
# bash variables
#---------------------------------------------------------------------------------------------

# colorful man page
# note: if this fraction is put in .profile, man & less will not work as expected
# fix-me, because I think that's weired and should not happen

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

hg(){ history | grep -i $* | sort -k 2 | uniq -s 7 | sort -g | more; }
hi()
{ 
    if [ "$1" -lt "30"  ];then    
        history $1
    else
        history $1 | less
    fi
}
hh(){ history 10; }
topN() { history | awk '{a[$'`echo "1 2 $HISTTIMEFORMAT" | wc -w`']++}END{for(i in a){print a[i] "\t" i}}' | sort -rn | head -20; }

#---------------------------------------------------------------------------#
#                             ls customization                              #
#---------------------------------------------------------------------------#

# enable color support of ls(LS_COLORS) and also add handy aliases
if [[ "$TERM" != "dumb" ]]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto -F'
fi

alias l='ls'
alias ll='ls -hl'
alias la='ls -A'
alias lla='ll -A'
#In case you type it incorrectly...
alias sl='ls'

# find most-recently modified file under current folder; sub-folder not considered.
alias newest='ll -t * | head -1'

# list file by size in descending order; sub-folder not considered.
alias bigfile='ll -S'

# count item under current foleder; 
alias num='expr $(ll | wc -l) - 1'

#show hierarchy in tree-view
# list size in human-friednly way, also apply nice ASCII line graph.
alias tree='tree -h -A'
# only list folder.
alias treed='tree -d'

# move around quickly.
alias ..='cd ..'
alias ...='cd ../..'
alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'

# df improved: show FS type, human-friendly size and ignore pseudo FS. 
alias df='LANG=en df -h -T -x tmpfs | grep -vE "(gvfs|procbususb|rootfs)"'

# show size in human-friednly way.
alias du='du -h'

# only show the total size.
alias dus='du -s'

# only show sub-folders of depth one.
alias du1='du -h --max-depth=1'

#sort by size; only consider sub-folders.
du2( )
{
    du -b --max-depth=1 | sort -nr | perl -pe 's{([0-9]+)}{sprintf "%.1f%s", $1>=2**30? ($1/2**30, "G"): $1>=2**20? ($1/2**20, "M"): $1>=2**10? ($1/2**10, "K"): ($1, "")}e'

}

#chmod related alias
alias cw='chmod u+w'
alias cW='chmod u-w'
alias cx='chmod u+x'
alias cX='chmod u-x'
alias cax='chmod a+x'
alias caX='chmod a-x'
alias 000='chmod 000'
alias 644='chmod 644'
alias 755='chmod 755'

#---------------------------------------------------------------------------#
#                         apt-get customization                             #
#---------------------------------------------------------------------------#

alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade -y --force-yes'


alias purge='sudo apt-get purge -y'
alias remove='sudo apt-get remove -y'
alias clean='sudo apt-get autoremove autoclean clean'
alias ssyn='sudo synaptic'

alias dpi='sudo dpkg -i' # install pkg
alias dpp='sudo dpkg -P' # purge pkg
alias dps='dpkg -s'      # search pkg name
alias dpS='dpkg -S'      # search file name
alias dpl='dpkg -l'      # list pkg summary
alias dpL='dpkg -L'      # list pkg details

# short name for'sudo apt-get install'
inst()
{
    local pkgname
    pkgname=$(echo $1|tr '[A-Z]' '[a-x]')
    sudo apt-get install -y $pkgname
}

#---------------------------------------------------------------------------------------------
# building customization 
#---------------------------------------------------------------------------------------------
alias conf='./configure'
alias mk='make'
alias mks='make --silent'
alias mi='make install'
alias mt='make test'
alias mkc='make clean'

# edit config file
alias rc=' vim ~/.bashrc'
alias vrc='vim ~/.vimrc'
alias src='vim ~/.screenrc'
alias vprc='vim ~/.vimperatorrc'
alias menu='sudo vim /boot/grub/menu.lst'
alias fstab='sudo vim /etc/fstab'


#---------------------------------------------------------------------------------------------
# Networking customization 
#---------------------------------------------------------------------------------------------

alias trace='tracepath'
alias mtr='mtr -t'
alias pi='pinger'
alias pingh='ping 127.0.0.1'
alias pingl='ping 192.168.1.1'
alias pingg='ping google.com' 

alias rnet='sudo /etc/init.d/networking restart'
alias rsmb='sudo /etc/init.d/samba restart'
alias center='ssh jekyll@t1000-edu.unix-center.net'
alias nets='netstat -anp'
alias netst='netstat -anpt'  #tcp ports
alias netsu='netstat -anpu'  #udp ports
alias listening='netstat -tlnp' #list all listening ports;root previlige is better
alias ax='axel'
alias get='wget -c'
alias mirror='wget --random-wait -c -r -p -e robots=off -U mozilla'
alias you='youtube-dl -t'
alias po='sudo pon dsl-provider'
alias myip="curl -s http://checkip.dyndns.org | sed 's/[a-zA-Z<>/ :]//g' "

alias vpn='sudo openvpn --config ~/.openvpn/alonweb.conf --ca ~/.openvpn/alonweb.crt'

alias mrsync='rsync -r -t -v --progress'

#---------------------------------------------------------------------------------------------
# Process management customization
#---------------------------------------------------------------------------------------------

#alias ps='ps -o stat,euid,ruid,tty,tpgid,sess,pgrp,ppid,pid,pcpu,comm'

# Tip: [\1]  is used to exclude grep from the final result
psg()
{
    target=$(echo $1 | sed "s/^\(.\)/[\1]/g")
    command=$(echo "COMMAND" | sed "s/^\(.\)/[\1]/g")
    #ps auxw | grep -E "$(echo $1 | sed "s/^\(.\)/[\1]/g")"
    ps auxw | grep -E "$target|$command"
}

alias pgrep='pgrep -l'

alias k='kill'
alias k9='kill -9'
alias ka='killall'
alias ka9='killall -9'
alias kag='killall -9 gmplayer'
alias kajobs='kill "$@" $(jobs -p)'

alias pause='kill -STOP'
alias jobs='jobs -l'
alias release='fuser -k'

alias a='alias'
alias b='cd ~/bin'
alias c='cd'
#alias d='sdcv'
alias D='cd ~/Desktop'
alias D2='cd ~/Desktop/Dropbox'
alias f='find'
alias fl='file'
alias g='grep'
alias h='help'
alias m='man'
alias ma='man -a'
alias mm='man man'
alias 0='popd'
alias p='pushd'
alias s='sudo'
alias t='xfce4-terminal -e luit &'
alias v='vim'
alias ht='htop'
alias wh='which'
alias gconf='gconf-editor'
alias su='su -l'
alias tp='type'
alias tpa='type -a'
alias scr='screen'

alias mp3tag='find . -iname "*.mp3" -execdir mid3iconv -e GBK {} \;'
alias hd='hexdump -C -v'
alias hd2='od -Ax -tx1z -v'

alias im-switch='im-switch -z default'
alias zhcon='zhcon --utf8 --drv=fb'

alias clip='mencoder -oac mp3lame -ovc lavc -o temp.avi'
alias clip2='mencoder -oac mp3lame -ovc lavc -o temp.avi -ovc xvid -xvidencopts fixed_quant=6'
#extract audio from video
#mplayer -ao pcm -vo null -vc dummy -dumpaudio -dumpfile <output-file> <input-file>
#ffmpeg -i <input.flv> -ab 128000 -ar 44100 <output.mp3>
#ffmpeg -vcodec copy -acodec copy -i orginalfile -ss 00:01:30 -t 0:0:20 newfile

#show currently mounted fs in nice layout
alias mnt='mount |grep -E "ext[2-4]|reiserfs|vfat|ntfs|xfs|jfs|zfs" |column -t'
alias mnta='sudo mount -a'
alias mntiso='sudo mocnt -t iso9660 -o user loop ro utf8'
cd2iso()
{
    isofile=$1;
    readom dev=/dev/cdrom f=$isofile
}

alias svn-versionalize="svn status |grep '\?' |awk '{print $2}'| xargs svn add"
alias svndiff='svn diff -diff-cmd=colordiff'
alias diff='colordiff'

alias recordscreen='/usr/bin/byzanz-record ~/screen_record.gif'

alias date='date "+%Y-%m-%d %A    %T %Z"'
alias gdb='gdb --quiet' # Do not print the introductory and copyright messages

#sort dot-formatted ip address in numericly-ascending way
alias sortip='sort -nt . -k 1,1 -k 2,2 -k 3,3 -k 4,4'

alias matrix='cmatrix -b ' #random bold character in matrix
alias terminator='terminator -m -b'
alias iotop='iotop -o'


###**********************************************************************###
###                             shell functions                          ###
###**********************************************************************###

#---------------------------------------------------------------
# interaction utilily
#---------------------------------------------------------------

#Often, the very next command after the cd command is 'ls', so why not combine them?. 
#Usage: cd PATH
cd() { builtin cd "${@:-$HOME}" && ls; }

#colorize follwoing text
#Usage: green hello
green(){ echo -e "\e[32;32m$@\e[0m"; }
red(){ echo -e "\e[32;31m$@\e[0m"; }

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
xx ()
{
    local item
    for item in "$@";do
        echo ${item}
        gnome-open ${item}
    done
}

#Simplify the usage of nautilus
#Usage naut [start-path]
naut()
{
    nautilus "${@:-$PWD}"
}


#---------------------------------------------------------------
# APT utilily
#---------------------------------------------------------------

#Usage: addkey2 0x5017d4931d0acade295b68adfc6d7d9d009ed615
addkey()
{
    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com $1
}

# View or append new entry into the apt-get sources.list
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

#View or append new entry automatically into the apt-get sources.list
#Usage: repo [ADDR-STR]
repo()
{
    case "$#" in
        0)
        sudo vim /etc/apt/sources.list
        ;;
        1)
        vimaction=$(mktemp -u).vimscript
        #Note, "\e\e" will be intepreted as <ESC> by VIM
        echo -ne "G2o\e\eGi$1\e\e:wq\n" >$vimaction
        sudo vim + -s $vimaction /etc/apt/sources.list >/dev/null 2>&1
        rm $vimaction
        ;;
    esac
}


#---------------------------------------------------------------
# Converting utilily
#---------------------------------------------------------------

#Convert one single pdf file to multiple png files,one png file correspond to one page
#Usage: pdf2png xxxx.pdf
pdf2png()
{
    convert -quality 100 -antialias -density 96 -transparent white -trim $1 $( basename $1 '.pdf')".png"
}

#transform manual to pure text file
#Usage: man2txt command... 
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
        if echo $(enca ${item} ) | grep -i "GB2312" ; then
            iconv -f gb18030  -t utf8 -c "${item}" > "${item}.new"  &&  mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"    
        fi
    done
}

# Tranform text from utf-8 encoding to gb*; old file is automatically renamed
# Usage: gb2u8  gbk-encoded.txt...
u82gb()
{
    local item

    for item in "$@";do
        if echo $(enca ${item} ) | grep -i "UTF-8" ; then
            iconv -f utf8 -t gb18030  -c "${item}" > "${item}.new"  &&  mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"    
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
#alias convmv-utf8='convmv -f gbk -t utf-8 -notest'
convmv_utf8 ()
{
    convmv -f gbk -t utf-8 --notest "$@"
}

#---------------------------------------------------------------
#  miscellaneous utilily
#---------------------------------------------------------------

# Empty specified files
# Usage: null file1 file2 ... fileN
null ()
{
    local item
    for item in "$@";do
        cat /dev/null > $item
    done
}


#share folder throuth http://localhost:8000 
#Usage: share FOLDER-PATH
share()
{
    builtin cd "${@:-$PWD}"
    python -m SimpleHTTPServer &
}

#get blacklist from authority and generate the needed command to block these suspicious ip
#Usage: blacklist
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
function glog() 
{
    git log --pretty=oneline --topo-order --graph --abbrev-commit $@
}

# show current folder's git branch info
parse_git_branch() 
{
    # tell 'cut' to use SPACE as delimiter
    git branch 2> /dev/null | sed -e '/^[^*]/d' | cut --delimiter=\  --fields=2
}

###**********************************************************************###
###                             auto completion                          ###
###**********************************************************************###

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

if [ -f ~/.bash.d/chs_completion.sh ]; then
    . ~/.bash.d/chs_completion.sh
fi

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

#utility of cdargs
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


