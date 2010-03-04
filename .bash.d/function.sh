#!/bin/bash
#===============================================================================
#
#          FILE:  function.sh
#
#         USAGE:  ./function.sh
#
#   DESCRIPTION:  Varisous bash functions
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  adaptee (), adaptee@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  2009年09月04日 00时43分52秒 CST
#      REVISION:  ---
#===============================================================================


#---------------------------------------------------------------------------#
#                               history related                             #
#---------------------------------------------------------------------------#

# grep your history!
# usage: hgrep KEY_WORD
function hgrep ()
{
    # sorted and uniqed.
    history | grep -i "$*" | sort -k 2 | uniq -s 7 | sort -g | grep -i "$*"

    # raw history list
    #history | grep -i "$*"
}

# list your history
# usage: hlist [recent-number]
function hlist ()
{
    if [ "$1" -lt "30"  ];then
        history "$1"
    else
        history "$1" | less
    fi
}

# list last ten commands
# usage: hh
function hh ()
{
    history 10;
}

function topN ()
{
    history | awk '{a[$'`echo "1 2 $HISTTIMEFORMAT" | wc -w`']++}END{for(i in a){print a[i] "\t" i}}' | sort -rn | head -20;

}

#---------------------------------------------------------------------------#
#                                 gnome  utility                            #
#---------------------------------------------------------------------------#

# open specified files with apporiate programs
# usage: go FILES...
function go ()
{
    local item
    for item in "$@";do
        #echo "${item}"
        #gnome-open "${item}"
        xdg-open "${item}"
    done
}

# open specified location( defalut pwd) with file-manager nautilus.
# usage: fm [location]
function fm ()
{
    nautilus "${@:-$PWD}"
}

# empty the trash box
function trashempty()
{
    empty-trash && notify-send -i ~/.icons/trash.png "Trash is emptied."
}

# open the trash box
function trashopen()
{
   xdg-open ~/.local/share/Trash
}

# enable touchpad
function padon ()
{
    synclient TouchpadOff=0
}

# disable touchpad
function padoff ()
{
    synclient TouchpadOff=1
}


#---------------------------------------------------------------------------#
#                              terminal  utility                            #
#---------------------------------------------------------------------------#

# create a backup for sepcified file/folder
# usage: bak [file/folder]
function bak()
{
    if [[ $# != 1  ]] ; then
        echo "Usage: bak [file/folder] "
        return 1
    fi

    local orig_name="$1"
    # put timestamp in to the bakcup name
    local backup_name="${1}.$(LANG=en date '+%Y-%m-%d').bak"

    # make sure the specified file exist
    if [[ ! -a "${orig_name}" ]] ; then
        echo "Error: ${orig_name} does not exist!"
        return 2
    fi

    # processs folder a bit differently
    if [[ -d "${orig_name}" ]] ; then
        cp -v -r "${orig_name}" "${backup_name}"
    else
        cp -v  "${orig_name}" "${backup_name}"
    fi
}


# often the next command after 'cd' is 'ls', so why not combine into one?
# usage: cl PATH
function cl() { builtin cd "${@:-$HOME}" && ls; }

# insert thousand separator into number, for better readability
# usage: commify NUMBER
function commify ()
{
    typeset text=${1}

    typeset bdot=${text%%.*}
    typeset adot=${text#${bdot}}

    typeset i commified
    (( i = ${#bdot} - 1 ))

    while (( i>=3 )) && [[ ${bdot:i-3:1} == [0-9] ]]; do
        commified=",${bdot:i-2:3}${commified}"
        (( i -= 3 ))
    done

    echo "${bdot:0:i+1}${commified}${adot}"
}

# return the extension part of a filename
# input:  hello.world.I.love.linux.iso
# output: iso
function extension()
{
    local filename="$1"
    echo ${filename##*.}
}

# remove the extension part of a filename
# input:  hello.world.I.love.linux.iso
# output: hello.world.I.love.linux
function trimextension()
{
    local filename="$1"
    echo ${filename%.*}
}

# create new folder and enter into it
# usage: md [mode] DIR
function md ()
{
    local newdir='_md_command_failed_'
    if [ -d "$1" ]; then # Dir exists, mention that...
        echo "$1 already exists..."
        newdir="$1"
    else
        # if mode is specified , use that
        if [ -n "$2" ]; then
            command mkdir -p -m $1 "$2" && newdir="$2"
        else
            command mkdir -p "$1" && newdir="$1"
        fi
    fi

    # No matter what, cd into it
    builtin cd "$newdir"
}

# always run man with English locale, because I do not like
# translated version
function man ()
{
    LANG=en_US.utf-8 command man $*
}


# simple wrapper for invoking  mplayer nicely with framebuffer
# mpf stands for mplayer with framebuffer
function mpf()
{
    file="$@"

    # FIXME:
    #if scale is set to 1024:768(the ideal size), some pixels will remain on the screen side
    # after mplayer exit.
    mplayer -vo fbdev2 -fs -x 1024 -y 768 -vf scale=1024:768 -really-quiet "${file}" >& /dev/null &

    # this is very important ;
    # clear the screen will make the display not interfered by console output
    fg ; clear
}

# grep the result of ps
# Usage: psg [CMD-NAME]
# Tip: [\1]  is used to exclude grep from the final result
function psg()
{
    target=$(echo $1 | sed "s/^\(.\)/[\1]/g")
    command=$(echo "COMMAND" | sed "s/^\(.\)/[\1]/g")
    #ps auxw | grep -E "$(echo $1 | sed "s/^\(.\)/[\1]/g")"
    ps ax | grep -i -E "$target|$command"
}


# canonicalize path (including resolving symlinks)
function realpath()
{
    # first consider accessable commnands
    if which "$1" > /dev/null ; then
        readlink -f $(which "$1")
    else
        readlink -f "$1"
    fi
}

# echo bash variables more easily
# here we use indirect refence format: ${!env_var}
# usage: e shell_var_name...
function e ()
{
    local item

    for item in "$@";do
        builtin echo "${!item}";
    done
}


# echo environment variables more easily(lower-case input is ok)
# here we use indirect refence format: ${!env_var}
# usage: ee env_var_name...
function ee ()
{
    local item

    for item in "$@";do
        env_var=$(echo "${item}" |tr '[a-z]' '[A-Z]');
        builtin echo "${!env_var}";
    done
}

# empty specified files
# usage: null files...
function null ()
{
    local item
    for item in "$@";do
        cat /dev/null > "${item}"
    done
}

# Colorize follwoing text
# usage: green TEXT
function green () { echo -e "${BRIGHTGREEN}$@${NOCOLOR}"; }
function red ()   { echo -e "${BRIGHTRED}$@${NOCOLOR}"; }


#---------------------------------------------------------------------------#
#                                 APT  utility                              #
#---------------------------------------------------------------------------#


# short name for 'sudo apt-get install'
function inst()
{
    local pkgname
    pkgname=$(echo $@ | tr '[A-Z]' '[a-x]')
    sudo apt-get install -y $pkgname
}

# add GPG key for debian-repo
# usage: addkey 0x5017d4931d0acade295b68adfc6d7d9d009ed615
function addkey ()
{
    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com "$1"
}

# view sources.list, or append new entry
# usage: addscr [source-entry]
function addsrc ()
{
    case "$#" in
        # when no argument is provided, view sources.list
        0)
        sudo vim /etc/apt/sources.list
        ;;
        # otherwise, append new entry
        *)
        echo -ne "\n$@\n"| sudo tee -a /etc/apt/sources.list  >/dev/null 2>&1
        ;;
    esac
}

# clean already-removed package's etc files.
# usage: purgecfg
function purgecfg ()
{
    dpkg -l | grep '^rc' | awk '{print $2}' | xargs sudo apt-get -y purge
}


#---------------------------------------------------------------------------#
#                               converting utilily                          #
#---------------------------------------------------------------------------#

# convert single pdf file to png files, one png file per one page
# usage: pdf2png xxxx.pdf
function pdf2png()
{
    convert -quality 100 -antialias -density 96 -transparent white -trim $1 \
    $( basename $1 '.pdf')".png"
}

function dir2iso()
{
    if [[ $# != 2 ]] ; then
        echo "Usage: dir2iso [folder-name] [iso-label] "
        return 1
    fi

    local folder="$1"
    local iso_label="$2"

    #genisoimage -r -J -joliet-long -input-charset utf-8 -hide boot.catalog -hide-joliet boot.catalog -V "${iso_label}" -o "${iso_label}.iso" "${folder}"
    mkisofs -r -J -joliet-long -input-charset utf-8 -hide boot.catalog -hide-joliet boot.catalog -V "${iso_label}" -o "${iso_label}.iso" "${folder}"

}

# convert manpages to plain text file
# usage: man2txt command...
function man2txt()
{
    local item
    for item in "$@";do
        man ${item} | col -b >"${item}.txt"
    done
}

# convert manpages to pdf file
# usage: man2pdf command...
function man2pdf()
{
    local item
    for item in "$@";do
        man -t ${item} | ps2pdf - >"${item}.pdf"
    done
}


#---------------------------------------------------------------------------#
#                               encoding utilily                            #
#---------------------------------------------------------------------------#

# convert filename to UTF-8 encoding
# usage convmv_utf8 FILES....
function convmv_utf8 ()
{
    convmv -f gbk -t utf-8 --notest "$@"
}

# tranform from gb* encoding to utf-8; old file is automatically renamed
# usage: gb2u8 files...
function gb2u8()
{
    local item
    for item in "$@";do
        if  enca "${item}" | grep -i 'GB2312\|Unrecognize' >/dev/null  ; then

            iconv -f gb18030  -t utf8 -c "${item}" > "${item}.new"  &&  \
            mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"

            echo "${item} is converted into utf-8 encoding"
        fi
    done
}

# tranform from utf-8 encoding to gb*; old file is automatically renamed
# usage: u82gb files...
function u82gb()
{
    local item

    for item in "$@";do
        if echo $(enca "${item}" ) | grep -i "UTF-8" >/dev/null ; then

            iconv -f utf8 -t gb18030  -c "${item}" > "${item}.new"  &&  \
            mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"

            echo "${item} is converted into gbk encoding."
        fi
    done

}

# tranform from utf-16 encoding into utf-8; old file is automatically renamed
# usage: u162u8 files...
function u162u8()
{
    local item

    for item in "$@";do
        if echo $(enca "${item}" ) | grep -i "UCS-2" >/dev/null ; then

            iconv -f utf16 -t utf8  -c "${item}" > "${item}.new"  &&
            \mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"

            echo "${item} is converted into utf-16 encoding."
        fi
    done
}

# tranform from utf-16 encoding into gbk; old file is automatically renamed
# usage: u162gb files...
function u162gb()
{
    local item

    for item in "$@";do
        if echo $(enca "${item}" ) | grep -i "UCS-2" >/dev/null ; then

            iconv -f utf16 -t gb18030  -c "${item}" > "${item}.new"  &&
            \mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"

            echo "${item} is converted into utf-16 encoding."
        fi
    done
}
#---------------------------------------------------------------------------#
#                           programming related                             #
#---------------------------------------------------------------------------#

# adjust the indentation of xml files in place
# usage: tidyxml xmlfiles...
function tidyxml ()
{
    local item
    for item in "$@";do
        tidy -xml -i -m "${item}"
    done
}

# show current folder's git branch info
function parse_git_branch()
{
    # tell 'cut' to use SPACE as delimiter
    git branch 2> /dev/null | sed -e '/^[^*]/d' | cut -f 2 -d ' '
}

#access the default git diff behavior
function git_diff()
{
    git diff --no-ext-diff -w "$@" | vim -R -
}

# set specifiles as 'assume unchanged', i.e, not tracking the modification in
# the workding tree;
# usage:git_set_assume_unchanged
function git_set_assume_unchanged ()
{
    git update-index --assume-unchanged ~/.gconf/apps/gnome-terminal/profiles/Default/%gconf.xml
    git update-index --assume-unchanged ~/.gconf/apps/gedit-2/plugins/filebrowser/on_load/%gconf.xml
    git update-index --assume-unchanged ~/.gconf/apps/gedit-2/preferences/ui/statusbar/%gconf.xml
    git update-index --assume-unchanged ~/.aMule/amule.conf
    git update-index --assume-unchanged ~/.qterm/qterm.cfg
    git update-index --assume-unchanged ~/.mplayer/gui.conf
    git update-index --assume-unchanged ~/.htoprc
}


# generate random string with specified length
# usage: randomstr N
function randomstr()
{
    strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n';
}


#---------------------------------------------------------------------------#
#                               network related                             #
#---------------------------------------------------------------------------#

# download file. use "$*" to protect  weird charater within args
function get ()
{
    # url is the last argument; here we make use the indirect expansion feature
    local url="${!#}"

    # option is all the other argument except the last
    local options=""
    local args_num=$#
    local args=("$@")
    for (( i = 0; i < ${args_num} - 1; i++ )); do
       options="${options} ${args[$i]}"
    done

    # note, we enclose the url with single-quote in order to protect special character
    echo "wget -c ${options} '${url}' "
    eval " wget -c ${options} '${url}' " && notify-send -i ~/.icons/gdebi.png  "Download finished!"
}


# show my actually ip .
function  myip ()
{
    echo $(curl -s http://whatismyip.org)
}


# delelte all mails in the mailbox
# usage: clearmail
function clearmail ()
{
    echo 'd *' | mail -N
}

# share folder throuth http://localhost:8000
# usage: share folder-path
function share()
{
    builtin cd "${@:-$PWD}"
    python -m SimpleHTTPServer &
}

# get blacklist from authority and generator the commmads
# for blocking these suspicious ip
# usage: blacklist
function blacklist()
{
    wget -qO - http://infiltrated.net/blacklisted|awk '!/#|[a-z]/&&/./{print "iptables -A INPUT -s "$1" -j DROP"}'
}

# use opendns.org for domain resolution
function opendns()
{
    cat /dev/null |sudo tee /etc/resolv.conf > /dev/null
    echo "#Generated by user-function opendns" | sudo tee -a /etc/resolv.conf >/dev/null
    echo "nameserver 208.67.222.222" | sudo tee -a /etc/resolv.conf >/dev/null
    sudo /etc/init.d/networking restart
}

# use gateway for domain resolution
function localdns()
{
    cat /dev/null |sudo tee /etc/resolv.conf > /dev/null
    echo "#Generated by user-function opendns" | sudo tee -a /etc/resolv.conf >/dev/null
    echo "nameserver 192.168.1.1" | sudo tee -a /etc/resolv.conf >/dev/null
    sudo /etc/init.d/networking restart
}

# grep files with specified suffix recursively, starting from current folder
# usage:
#   greps  [pattern]
#   greps  [pattern] [suffix_filter]
# example:
#   greps include txt

function greps()
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

