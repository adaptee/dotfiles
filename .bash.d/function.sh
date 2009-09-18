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
hgrep ()
{ 
    # sorted and uniqed.
    history | grep -i "$*" | sort -k 2 | uniq -s 7 | sort -g | grep -i "$*"

    # raw history list
    #history | grep -i "$*"
}

# list your history
# usage: hlist [recent-number]
hlist ()
{ 
    if [ "$1" -lt "30"  ];then    
        history "$1"
    else
        history "$1" | less
    fi
}

# list last ten commands
# usage: hh
hh ()
{ 
    history 10;
}

topN () 
{
    history | awk '{a[$'`echo "1 2 $HISTTIMEFORMAT" | wc -w`']++}END{for(i in a){print a[i] "\t" i}}' | sort -rn | head -20; 

}

#---------------------------------------------------------------------------#
#                                 gnome  utility                            #
#---------------------------------------------------------------------------#

# open specified files with apporiate programs
# usage: go FILES...
go ()
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
fm ()
{
    nautilus "${@:-$PWD}"
}

#---------------------------------------------------------------------------#
#                              terminal  utility                            #
#---------------------------------------------------------------------------#

# often the next command after 'cd' is 'ls', so why not combine into one? 
# usage: cl PATH
cl() { builtin cd "${@:-$HOME}" && ls; }

# create new folder and enter into it
# this function hide the useless command dir
md(){ mkdir -p "$1" && cd "$1"; }

# canonicalize path (including resolving symlinks) 
realpath()
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
e () 
{
    local item

    for item in "$@";do
        builtin echo "${!item}";
    done
}  


# echo environment variables more easily(lower-case input is ok)
# here we use indirect refence format: ${!env_var}
# usage: ee env_var_name...
ee () 
{
    local item

    for item in "$@";do
        env_var=$(echo "${item}" |tr '[a-z]' '[A-Z]'); 
        builtin echo "${!env_var}";
    done
}  

# empty specified files
# usage: null files...
null ()
{
    local item
    for item in "$@";do
        cat /dev/null > "${item}"
    done
}

# Colorize follwoing text
# usage: green TEXT
green () { echo -e "${BRIGHTGREEN}$@${NOCOLOR}"; }
red ()   { echo -e "${BRIGHTRED}$@${NOCOLOR}"; }


#---------------------------------------------------------------------------#
#                                 APT  utility                              #
#---------------------------------------------------------------------------#

# add GPG key for debian-repo
# usage: addkey 0x5017d4931d0acade295b68adfc6d7d9d009ed615
addkey ()
{
    sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com "$1"
}

# view sources.list, or append new entry 
# usage: addscr [source-entry]
addsrc ()
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
purgecfg ()
{
    dpkg -l | grep '^rc' | awk '{print $2}' | xargs sudo apt-get -y purge
}


#---------------------------------------------------------------------------#
#                               converting utilily                          #
#---------------------------------------------------------------------------#

# convert single pdf file to png files, one png file per one page
# usage: pdf2png xxxx.pdf
pdf2png()
{
    convert -quality 100 -antialias -density 96 -transparent white -trim $1 \
    $( basename $1 '.pdf')".png"
}


# burn cdrom's content's into iso image.
# usage: cd2iso iso-name
cd2iso()
{
    case "$#" in
        0)
        echo "buddy, please provide a name for the target iso image"
        ;;
        1)
        isofile="$1";
        readom dev=/dev/cdrom f="${isofile}"
        ;;
    esac
}

# convert manpages to plain text file
# usage: man2txt command...
man2txt()
{
    local item
    for item in "$@";do
        man ${item} | col -b >"${item}.txt" 
    done
}

# convert manpages to pdf file
# usage: man2pdf command...
man2pdf()
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
convmv_utf8 ()
{
    convmv -f gbk -t utf-8 --notest "$@"
}

# tranform from gb* encoding to utf-8; old file is automatically renamed
# usage: gb2u8 files...
gb2u8()
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
u82gb()
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
u162u8()
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

#---------------------------------------------------------------------------#
#                           programming related                             #
#---------------------------------------------------------------------------#

# adjust the indentation of xml files in place 
# usage: indentxml xmlfiles...
indentxml ()
{
    local item
    for item in "$@";do
        tidy -xml -i -m "${item}"
    done
}

# shows  git history as ASCII graph
# usage: glog
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

# set specifiles as 'assume unchanged', i.e, not tracking the modification in
# the workding tree;
# usage:git_set_assume_unchanged
git_set_assume_unchanged ()
{
    git update-index --assume-unchanged ~/.gconf/apps/gnome-terminal/profiles/Default/%gconf.xml
    git update-index --assume-unchanged ~/.gconf/apps/gedit-2/plugins/filebrowser/on_load/%gconf.xml
    git update-index --assume-unchanged ~/.gconf/apps/gedit-2/preferences/ui/statusbar/%gconf.xml
    git update-index --assume-unchanged ~/.aMule/amule.conf
}


# generate random string with specified length
# usage: randomstr N
randomstr()
{
    strings /dev/urandom | grep -o '[[:alnum:]]' | head -n $1 | tr -d '\n';
}


#---------------------------------------------------------------------------#
#                               network related                             #
#---------------------------------------------------------------------------#

# delelte all mails in the mailbox
# usage: clearmail
clearmail ()
{
    echo 'd *' | mail -N
}

# share folder throuth http://localhost:8000 
# usage: share folder-path
share()
{
    builtin cd "${@:-$PWD}"
    python -m SimpleHTTPServer &
}

# get blacklist from authority and generator the commmads 
# for blocking these suspicious ip
# usage: blacklist
blacklist()
{
    wget -qO - http://infiltrated.net/blacklisted|awk '!/#|[a-z]/&&/./{print "iptables -A INPUT -s "$1" -j DROP"}'
}

# grep files with specified suffix recursively, starting from current folder 
# usage:
#   greps  [pattern] 
#   greps  [pattern] [suffix_filter]
# example:
#   greps include txt

greps() 
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

