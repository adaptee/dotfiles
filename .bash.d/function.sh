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
#                               shell functions                             #
#---------------------------------------------------------------------------#


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
#Usage: man2txt command1, command2, command3
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
