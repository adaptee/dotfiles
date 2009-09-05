#!/bin/bash
#===============================================================================
#
#          FILE:  alias.sh
# 
#         USAGE:  ./alias.sh 
# 
#   DESCRIPTION:  where alias is placed toghether. 
# 
#       OPTIONS:  ---
#  REQUIREMENTS:  ---
#          BUGS:  ---
#         NOTES:  ---
#        AUTHOR:  adaptee (), adaptee@gmail.com
#       COMPANY:  Open Source Corporation
#       VERSION:  1.0
#       CREATED:  2009年08月01日 00时06分40秒 CST
#      REVISION:  ---
#===============================================================================

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

#---------------------------------------------------------------------------#
#                                   ls alias                                #
#---------------------------------------------------------------------------#

# enable color support of ls(LS_COLORS) and also add handy aliases
if [[ "$TERM" != "dumb" ]]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto -F'
fi

alias l='ls'
alias ll='ls -hl'

# A means show hidden items. but not including . and ..
alias la='ls -A'  
alias lla='ll -A'

#In case you type 'ls' as 'sl'....
alias sl='ls'

# find most-recently modified file under current folder; sub-folder not considered.
alias newest='ll -t * | head -1'

# list file by size in descending order; sub-folder not considered.
alias bigfile='ll -S'

# count item under current foleder; 
alias num='expr $(ll | wc -l) - 1'


#---------------------------------------------------------------------------#
#                                   cd alias                                #
#---------------------------------------------------------------------------#

# move around quickly.
alias ..='cd ..'
alias ...='cd ../..'
alias u='cd ..'
alias uu='cd ../..'
alias uuu='cd ../../..'

#---------------------------------------------------------------------------#
#                                 tree alias                                #
#---------------------------------------------------------------------------#

#show folder hierarchy in tree-view
# list size in human-friednly way, also apply nice ASCII line graph.
alias tree='tree -h -A'
# only list folder.
alias treed='tree -d'


#---------------------------------------------------------------------------#
#                         df & du & mount alias                             #
#---------------------------------------------------------------------------#

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

#show currently mounted partition in nice layout
alias mnt='mount |grep -E "ext[2-4]|reiserfs|vfat|ntfs|xfs|jfs|zfs" |column -t'
# remount all partition.
alias mnta='sudo mount -a'
# mount iso image..
alias mntiso='sudo mount -t iso9660 -o user loop ro utf8'

#---------------------------------------------------------------------------#
#                                 chmod alias                               #
#---------------------------------------------------------------------------#

# lower case means "+", while upper case means "-"
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
#                                process alias                              #
#---------------------------------------------------------------------------#

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

#kill all mplayer, useful when playing broken video.
alias kag='killall -9 gmplayer'

#kail all backgound jobs
alias kajobs='kill "$@" $(jobs -p)'

# pause sepcified process.
alias pause='kill -STOP'

# list all jobs with its process id.
alias jobs='jobs -l'

# kill whatever process who is occupying specified file.
alias release='fuser -k'

#---------------------------------------------------------------------------#
#                                 apt-get alias                             #
#---------------------------------------------------------------------------#

alias update='sudo apt-get update'
alias upgrade='sudo apt-get upgrade -y --force-yes'

alias purge='sudo apt-get purge -y'
alias clean='sudo apt-get autoremove autoclean clean'
alias ssyn='sudo synaptic'

alias dpi='sudo dpkg -i' # install pkg
alias dpp='sudo dpkg -P' # purge pkg
alias dps='dpkg -s'      # search pkg name
alias dpS='dpkg -S'      # search file name
alias dpl='dpkg -l'      # list pkg summary
alias dpL='dpkg -L'      # list pkg details

# short name for 'sudo apt-get install'
inst()
{
    local pkgname
    pkgname=$(echo $1|tr '[A-Z]' '[a-x]')
    sudo apt-get install -y $pkgname
}

#---------------------------------------------------------------------------#
#                                   make alias                              #
#---------------------------------------------------------------------------#

alias conf='./configure'

alias mk='make'
alias mks='make --silent'
alias mi='make install'
alias mt='make test'
alias mkc='make clean'

#---------------------------------------------------------------------------#
#                                     rc alias                              #
#---------------------------------------------------------------------------#

# edit config file
alias rc=' vim ~/.bashrc'
alias vrc='vim ~/.vimrc'
alias src='vim ~/.screenrc'
alias vprc='vim ~/.vimperatorrc'
alias grc='vim ~/.gitconfg'
alias menu='sudo vim /boot/grub/menu.lst'
alias fstab='sudo vim /etc/fstab'


#---------------------------------------------------------------------------#
#                                network alias                              #
#---------------------------------------------------------------------------#

alias pi='pinger'
alias pingl='ping 127.0.0.1'
alias pingg='ping 192.168.1.1'

alias trace='tracepath'
alias mtr='mtr -t'

alias rnet='sudo /etc/init.d/networking restart'
alias rsmb='sudo /etc/init.d/samba restart'
alias center='ssh jekyll@t1000-edu.unix-center.net'

alias nets='netstat -anp'
alias netst='netstat -anpt'     # only show tcp ports
alias netsu='netstat -anpu'     # only show udp ports
alias listening='netstat -tlnp' # list all listening ports;root previlige would be better

alias ax='axel'
alias get='wget -c'

# download whole site.
alias mirror='wget --random-wait -c -r -p -e robots=off -U mozilla'

# download viedo from youtube and preserce original title.
alias you='youtube-dl -t'

# dial-up quickly
alias po='sudo pon dsl-provider'

# show my actually ip .
alias myip="curl -s http://checkip.dyndns.org | sed 's/[a-zA-Z<>/ :]//g' "

# start vpn quickly.
alias vpn='sudo openvpn --config ~/.openvpn/alonweb.conf --ca ~/.openvpn/alonweb.crt'

alias booksync='rsync -r -t -v --progress --delete ~/prog/EBook /media/backup/'

# solve the encoding problem seamlessly.
alias smth='luit -encoding gbk telnet bbs.newsmth.net'
#---------------------------------------------------------------------------#
#                             top useful alias                              #
#---------------------------------------------------------------------------#

alias a='alias'
alias b='cd ~/bin'
# note, c is defined in function.sh
alias D='cd ~/Desktop'
alias D2='cd ~/Desktop/Dropbox'
alias f='find'
alias fl='file'
alias g='grep'
alias gi='grep -i'
alias gconf='gconf-editor'
alias h='help'
alias m='man'
alias ma='man -a'
alias mm='man man'
alias o='popd'
alias p='pushd'
alias s='sudo'
#switch to specified user's environment, making su safer.
alias su='su -l'
alias scr='screen'
alias t='htop'
alias tp='type'
alias tpa='type -a'
alias v='vim'
alias wh='which'

# convert id3 tag's encoding.
alias mp3tag='find . -iname "*.mp3" -execdir mid3iconv -e GBK {} \;'




#---------------------------------------------------------------------------#
#                                  misc alias                               #
#---------------------------------------------------------------------------#

alias svn-versionalize="svn status |grep '\?' |awk '{print $2}'| xargs svn add"
alias svndiff='svn diff -diff-cmd=colordiff'
alias diff='colordiff'

alias recordscreen='/usr/bin/byzanz-record ~/screen_record.gif'

# show date in pretty format.
alias date='date "+%Y-%m-%d %A    %T %Z"'

# Do not print the introductory and copyright messages
alias gdb='gdb --quiet' 

#sort dot-formatted ip address in numericly-ascending way
alias sortip='sort -nt . -k 1,1 -k 2,2 -k 3,3 -k 4,4'

alias matrix='cmatrix -b ' #random bold character in matrix
alias terminator='terminator -m -b'
alias iotop='iotop -o'

alias clip='mencoder -oac mp3lame -ovc lavc -o temp.avi'
alias clip2='mencoder -oac mp3lame -ovc lavc -o temp.avi -ovc xvid -xvidencopts fixed_quant=6'

alias hd='hexdump -C -v'
alias hd2='od -Ax -tx1z -v'

alias im-switch='im-switch -z default'
alias zhcon='zhcon --utf8 --drv=fb'
