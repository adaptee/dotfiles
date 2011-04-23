#!/bin/sh

# create a backup for specified file/folder
# usage: bak [file/folder]
function bak()
{
    if [[ $# != 1  ]] ; then
        echo "Usage: bak [file/folder] "
        return 1
    fi

    local orig_name="$1"
    # strip tailing '/', if that exist
    orig_name=${orig_name%/}

    # put timestamp in to the backup name
    local backup_name="${orig_name}-$(LANG=en date '+%Y-%m-%d').bak"

    # make sure the specified file exist
    if [[ ! -a "${orig_name}" ]] ; then
        echo "Error: ${orig_name} does not exist!"
        return 2
    fi

    # process folder a bit differently
    if [[ -d "${orig_name}" ]] ; then
        cp -v -r "${orig_name}" "${backup_name}"
    else
        cp -v  "${orig_name}" "${backup_name}"
    fi
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





# canonicalize path (including resolving symlinks)
function realpath()
{
    readlink -f "$1"
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

# Colorize following text
# usage: green-echo TEXT
function green () { echo -e "${BRIGHTGREEN}$@${NOCOLOR}"; }
function red ()   { echo -e "${BRIGHTRED}$@${NOCOLOR}"; }



#---------------------------------------------------------------------------#
#                           programming related                             #
#---------------------------------------------------------------------------#

# adjust the indentation of XML files in place
# usage: tidyxml xmlfiles...
function tidyxml ()
{
    local item
    for item in "$@";do
        tidy -xml -i -m "${item}"
    done
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


# show my actually ip .
function  myip ()
{
    echo $(curl -s http://whatismyip.org)
}


# delete all mails in the mailbox
# usage: clearmail
function clearmail ()
{
    echo 'd *' | mail -N
}

# share folder through http://localhost:8000
# usage: share folder-path
function share()
{
    cd "${@:-$PWD}" && python -m SimpleHTTPServer &
}

# grep files with specified suffix recursively, starting from current folder
# usage:
#   grep-suffix  [pattern]
#   grep-suffix  [pattern] [suffix_filter]
# example:
#   grep-suffix include txt

function grep-suffix()
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

# build qterm
function build-qterm()
{
    rm ~/code/qterm/build/* -rf
    cd ~/code/qterm/build

    cmake .. -DCMAKE_INSTALL_PREFIX=/usr/ -DQTERM_ENABLE_SCRIPT_DEBUGGER=OFF -DQTERM_ENABLE_PHONON=OFF -DQTERM_ENABLE_DBUS=OFF
    make

    cd -
}


# better cp ;
function bcp ()
{
    cp -v -a --parents "$1" "$2"
}


# count the line num of output of follwing command
function count ()
{
    (eval $@) | wc -l
}

# num is shorter to type
alias num='count'


# get the pwd of specified process by PID
# [Example] getpwd 1023 3045
function getpwd()
{
    pwdx $@
}


# minimal calculator
function calc()
{
    awk "BEGIN{ print $* }"
}

# date for different areas
function dates
{
    for i in US/Eastern Asia/Shanghai Europe/London; do
        printf %-22s "$i:";TZ=$i date +"%m-%d %a %H:%M"
    done
}


