#!/bin/bash
#===============================================================================
#
#          FILE:  ubuntu.sh
#
#         USAGE:  ./ubuntu.sh
#
#   DESCRIPTION:  ubuntu specific setting for bash
#
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  adaptee (), adaptee@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  05/07/10 14:01:56 CST
#      REVISION:  ---
#===============================================================================

alias rnet='sudo /etc/init.d/networking restart'
alias rsmb='sudo /etc/init.d/smbd restart'


#---------------------------------------------------------------------------#
#                                 apt-get alias                             #
#---------------------------------------------------------------------------#

# apt-get is hard to type!
alias apt='apt-get'

alias update='sudo apt-get update'
alias upgrade='sudo apt-get dist-upgrade -y --force-yes'

alias purge='sudo apt-get purge -y --force-yes'
alias syn='sudo synaptic'

alias clean='sudo apt-get clean'

alias dpi='sudo dpkg -i' # install pkg
alias dpp='sudo dpkg -P' # purge pkg
alias dps='dpkg -s'      # search pkg name
alias dpS='dpkg -S'      # search file name
alias dpl='dpkg -l'      # list pkg summary
alias dpL='dpkg -L'      # list pkg contents


# show package size in sorted order
function pac-size ()
{
    dpkg-query -W --showformat='${Installed-Size;20}\t${Package}\n' | sort -k1,1n | awk '{printf("%15.2f MB\t %s\n",$1/1024, $2)}'

}


function old-kernels ()
{
    dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d'
}

function old-kernels-purge ()
{
    dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge

}

function old-pkg-purge ()
{
    sudo aptitude purge ~o
}
