#!/bin/bash
#===============================================================================
#
#          FILE:  alias.sh
#
#         USAGE:  ./alias.sh
#
#   DESCRIPTION:  where alias is placed together.
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

# enable color support of ls(LS_COLORS)
if [[ "$TERM" != "dumb" ]]; then
    eval "$(dircolors -b)"
    alias ls='ls --color=auto '
fi

# 'F' means show trailing handy hints of the entry type
alias l='ls -F'
# 'A' means show hidden items. but not including . and ..
alias la='l -A'

# '-1' means one file per line
alias l1='l -1'

# show detailed info
alias ll='l -hl'
alias lla='ll -A'

# only list sub-directory under current directory
alias lf='ls -hl -d */'

# In case you type 'ls' as 'sl'....
alias sl='ls'

## find most-recently modified file under current folder; sub-folder not considered.
alias latest='ll -t * | head -1'

## list file by size in descending order; sub-folder not considered.
alias bigfile='ll -S| head -3'

# count item under current folder;
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

# use single '-' to jump to previous folder.
alias -- -='cd -'

# list one item per line , with prepending index.
alias dir='dirs -v'

#---------------------------------------------------------------------------#
#                                 tree alias                                #
#---------------------------------------------------------------------------#

# show folder hierarchy in tree-view
# '-h' : list size in human-friendly way,
# '-A: : apply nice ASCII line graph.
alias tree='tree -h -A -N '
# only list folder.
alias treed='tree -d'


#---------------------------------------------------------------------------#
#                         df & du & mount alias                             #
#---------------------------------------------------------------------------#

# df improved: show FS type, human-friendly size and ignore pseudo FS.
alias df='LANG=en df -h -T -x tmpfs | grep -vE "(gvfs|procbususb|rootfs)"'

# show size in human-friendly way.
alias du='du -h'

# only show the total size.
alias dus='du -s'

# only show sub-folders of depth one.
alias du1='du -h --max-depth=1'

#sort by size; only consider sub-folders.
function du2 ( )
{
    du -b --max-depth=1 | sort -nr | perl -pe 's{([0-9]+)}{sprintf "%.1f%s", $1>=2**30? ($1/2**30, "G"): $1>=2**20? ($1/2**20, "M"): $1>=2**10? ($1/2**10, "K"): ($1, "")}e'

}

#show currently mounted partition in nice layout
alias mnt='mount |grep -E "ext[2-4]|reiserfs|vfat|ntfs|xfs|jfs|zfs" |column -t'
# remount all partition.
alias mnta='sudo mount -a'

#---------------------------------------------------------------------------#
#                                 chmod alias                               #
#---------------------------------------------------------------------------#

# lower case means "+", while upper case means "-"
alias cw='chmod u+w'
alias cW='chmod u-w'
alias cx='chmod a+x'
alias cX='chmod a-x'
alias 644='chmod 644'
alias 755='chmod 755'

#---------------------------------------------------------------------------#
#                                process alias                              #
#---------------------------------------------------------------------------#

# customize the displaying layout for command ps.
alias ps='ps -w -o user,pid,ppid,%cpu,%mem,vsz,rss,tname,stat,policy,wchan,start_time,bsdtime,args'

# '-n' means sort sibling processes by numeric pid, not by name
alias pstree='pstree -n'

alias pgrep='pgrep -l'

alias k='kill'
alias k9='kill -9'
alias ka='killall'
alias ka9='killall -9'

alias kaa='killall -9 amule'
alias kaf='killall -9 firefox'
alias kas='killall swiftfox-bin'
alias kad='killall -9 gnome-do'
#kill all mplayer, useful when playing broken video.
alias kam='killall -9 mplayer;killall -9 gmplayer;killall -9 smplayer'


#kill all background jobs
alias kajobs='kill "$@" $(jobs -p)'

# pause specified process.
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

alias purge='sudo apt-get purge -y --force-yes'
alias syn='sudo synaptic'

alias dpi='sudo dpkg -i' # install pkg
alias dpp='sudo dpkg -P' # purge pkg
alias dps='dpkg -s'      # search pkg name
alias dpS='dpkg -S'      # search file name
alias dpl='dpkg -l'      # list pkg summary
alias dpL='dpkg -L'      # list pkg details

# use more friendly pacman
which pacman-color >& /dev/null &&  alias pacman='pacman-color'

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
alias irc='vim ~/.inputrc'
alias vrc='vim ~/.vimrc'
alias src='vim ~/.screenrc'
alias vprc='vim ~/.vimperatorrc'
alias grc='vim ~/.gitconfig'
alias menu='vim /boot/grub/menu.lst'
alias fstab='vim /etc/fstab'
alias smb='vim /etc/samba/smb.conf'


#---------------------------------------------------------------------------#
#                                network alias                              #
#---------------------------------------------------------------------------#

alias pi='pinger'

alias dns='cat /etc/resolv.conf'

alias trace='tracepath'
alias mtr='mtr -t'

alias rnet='sudo /etc/init.d/networking restart'
alias rsmb='sudo /etc/init.d/samba restart'

alias nets='netstat -anp'
alias netst='netstat -anpt'     # only show tcp ports
alias netsu='netstat -anpu'     # only show udp ports
alias listening='netstat -tlnp' # list all listening ports;root previlige would be better

alias ax='axel'

# download whole site.
alias mirror='wget --random-wait -c -r -p -e robots=off -U mozilla'

# download video from youtube and preserve original title.
alias you='youtube-dl -t'

# dial-up quickly
alias po='sudo pon dsl-provider'


# start vpn quickly.
alias vpn='sudo openvpn --config ~/.openvpn/alonweb.conf --ca ~/.openvpn/alonweb.crt'

# solve the encoding problem seamlessly.
alias smth='luit -encoding gbk telnet bbs.newsmth.net'

# start gappproxy local client
alias proxy='python ~/bin/gae/localproxy/proxy.py'

#---------------------------------------------------------------------------#
#                             top useful alias                              #
#---------------------------------------------------------------------------#

alias a='alias'
alias b='cd ~/bin'
alias bd='cd ~/.bash.d'
alias c='cl'
alias D='cd ~/Desktop'
alias D2='cd ~/Desktop/Dropbox'
alias d2='cd ~/dotfiles'
alias k4='cd ~/.kde4/share/'
alias rc='cd ~/.vim/rc'
# show date in pretty format.
alias dt='date "+%Y-%m-%d %A    %T %Z"'
alias f='find'
alias fl='file'
alias ff='cd ~/.mozilla/firefox/'
alias g='grep'
alias gi='grep -i'
alias gl='grep -l'
alias gn='grep -n'
alias gr='grep -r'
alias gv='grep -v'
alias gconf='gconf-editor'
alias h='help'
alias io='iotop -o'
alias log='cd /var/log'
alias m='man'
alias ma='man -a'
alias mb='man bash'
alias mf='man find'
alias mg='man grep'
alias ml='man ls'
alias mm='man man'
alias ms='man sed'
alias mp='mplayer'
alias smp='smplayer'
alias mon='bmon -p wlan0'
alias o='popd'
alias p='pushd'
alias py='python'
alias ipy='ipython'
alias s='sudo'
#switch to specified user's environment, making su safer.
alias su='su -l'
alias scr='screen'
alias t='htop'
alias tp='type'
alias tpa='type -a'
alias v='vim -p'
alias vd='vimdiff'
alias vi='vim -p'
alias vim='vim -p'
alias wh='which'
# '-w' means supporting wild-cards
alias what='whatis -w'
alias where='whereis'
alias x='xargs'
alias x0='xargs -0'

# convert id3 tag's encoding.
#alias mp3tag='find . -iname "*.mp3" -execdir mid3iconv -e GBK {} \;'




#---------------------------------------------------------------------------#
#                                  misc alias                               #
#---------------------------------------------------------------------------#

# ack-grep is a better grep!
# alias it to ack  only if it is installed as ack-grep
which ack-grep >& /dev/null &&  alias ack=ack-grep

# generated unified  result
alias diff='diff -aruN'

alias cdiff='colordiff'

alias svn-versionalize="svn status |grep '\?' |awk '{print $2}'| xargs svn add"
alias svndiff='svn diff -diff-cmd=colordiff'

alias recordscreen='/usr/bin/byzanz-record ~/screen_record.gif'


# Do not print the introductory and copyright messages
alias gdb='gdb --quiet'

#sort dot-formatted ip address in numericly-ascending way
alias sortip='sort -nt . -k 1,1 -k 2,2 -k 3,3 -k 4,4'

alias matrix='cmatrix -a -b -x'
alias terminator='terminator -m -b'

alias clip='mencoder -oac mp3lame -ovc lavc -o temp.avi'
alias clip2='mencoder -oac mp3lame -ovc lavc -o temp.avi -ovc xvid -xvidencopts fixed_quant=6'

alias hd='hexdump -C -v'
alias hd2='od -Ax -tx1z -v'

alias im-switch='im-switch -z default'
alias zhcon='zhcon --utf8 --drv=fb'


# show process info in ps style
alias fuser='fuser -v'

# use MB as unit
alias free='free -m'

alias sp='aspell check'
alias dict='diction -b -s -L en'

alias em='emacs'
# lanuch the console version of emacs
alias emc='emacs -nw'

alias aml='tail ~/.aMule/logfile'


# prevent typo
alias mr='rm'


# create subfolder with the same name, if necessary, before extracting
alias unp='unp -u'

alias gst='git status'
