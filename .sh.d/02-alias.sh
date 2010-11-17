#!/bin/sh

#---------------------------------------------------------------------------#
#                                   ls alias                                #
#---------------------------------------------------------------------------#

# enable color support of ls(LS_COLORS)
if [[ "$TERM" != "dumb" ]]; then
    eval "$(dircolors -b)"
    #  -X     sort alphabetically by entry extension
    alias ls='ls -X --group-directories-first --color=auto'
else
    alias ls='ls -X --group-directories-first'
fi

# 'F' means show trailing handy hints of the entry type
alias l='ls -F'
# 'A' means show hidden items. but not including . and ..
alias la='l -A'

# '-1' means one file per line
alias l1='l -1'

# show detailed info
# show time in the format of yyyy-mm-dd
alias ll='l -hl --time-style=long-iso'
alias lla='ll -A'

# only list sub-directory under current directory
alias lf='ll -d */'

# In case you type 'ls' as 'sl'....
alias sl='ls'

## find most-recently modified file under current folder; sub-folder not considered.
alias latest='ll -t * | head -1'

## list file by size in descending order; sub-folder not considered.
alias bigfile='ll -S| head -3'


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

alias A='cd ~/audio/ACG'
alias I='cd ~/down/Incoming/'
alias T='cd ~/down/Temp/'

alias b='cd ~/bin'

alias bd='cd ~/.bash.d'
alias sd='cd ~/.sh.d'
alias zd='cd ~/.zsh.d'

alias D='cd ~/Desktop'
alias D2='cd ~/Desktop/Dropbox'
alias d2='cd ~/dotfiles'
alias k4='cd ~/.kde4/share/'

alias ff='cd ~/.mozilla/firefox/'
alias rc='cd ~/.vim/rc'

alias log='cd /var/log'
alias core='cd /tmp/coredump/'

alias p='pwd'
alias pu='pushd'
alias po='popd'


#---------------------------------------------------------------------------#
#                                 tree alias                                #
#---------------------------------------------------------------------------#

# show folder hierarchy in tree-view
# '-h' : list size in human-friendly way,
# '-A: : apply nice ASCII line graph.
# '--dirsfirst :  list dir before  file
alias tree='tree -h -A -N --dirsfirst'
# only list folder.
alias treed='tree -d'


#---------------------------------------------------------------------------#
#                         df & du & mount alias                             #
#---------------------------------------------------------------------------#

# df improved: show FS type, human-friendly size and ignore pseudo FS.
alias df='LANG=en df -h -T -x tmpfs | grep -vE "(tmpfs|gvfs|procbususb|rootfs|devtmpfs|debugfs)"'

# show the size of direct-subentry, and sort them in acednding order by size
alias du='command du -h --max-depth=1 --one-file-system |sort -h'

# show the total size
alias dus='command du -h -s --one-file-system'

# make the output of mount looks better
alias mount='mount | column -t'

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
alias vrc='vim ~/.vimrc'
alias vprc='vim ~/.vimperatorrc'
alias grc='vim ~/.gitconfig'
alias menu='vim /boot/grub/menu.lst'
alias fstab='vim /etc/fstab'
alias smb='vim /etc/samba/smb.conf'


#---------------------------------------------------------------------------#
#                                network alias                              #
#---------------------------------------------------------------------------#

alias pi='pinger --quiet'

alias dns='cat /etc/resolv.conf'

alias fping='fping -a'

# show numeric ip address
alias arp='arp -n'

# this is much simpler than command arp
#alias arp='cat /proc/net/arp | grep -v "00:00:00:00:00:00" '


# scan a subnet
# [Example] scan 192.168.1.0/24
alias scan='nmap -sP '

alias trace='tracepath'
alias mtr='mtr -t'

alias nets='netstat -anp'
alias netst='netstat -anpt'     # only show tcp ports
alias netsu='netstat -anpu'     # only show udp ports

alias listening='netstat -tlnp' # list all listening ports;root previlige would be better
alias listening='ss -l -p'      # list all listening ports and corrsponding process

alias ax='axel'

# download whole site.
alias mirror='wget --random-wait -c -r -p -e robots=off -U mozilla'

# download video from youtube and preserve original title.
alias you='youtube-dl -t'

# dial-up quickly
alias po='sudo pon dsl-provider'

# solve the encoding problem seamlessly.
alias smth='luit -x -encoding gbk telnet bbs.newsmth.net'

# start gappproxy local client
alias proxy='python ~/bin/gae/localproxy/proxy.py'



#---------------------------------------------------------------------------#
#                                 Grep quickly                              #
#---------------------------------------------------------------------------#

alias egrep='egrep -I --color=auto'

# '-I' means returning no match for any binary file
alias g='grep -I --color=auto'

alias gi='g -i'
alias gl='g -l'
alias gn='g -n'
alias gr='g -r'
alias gv='g -v'

#---------------------------------------------------------------------------#
#                                   Others                                  #
#---------------------------------------------------------------------------#

alias a='alias'
alias c='cl'

# show date in pretty format.
alias dt='date "+%Y-%m-%d %A    %T %Z"'

alias fl='file'
alias h='help'
alias io='iotop -o'
alias m='man'
alias ma='man -a'
alias mf='man -f'
alias mm='man man'
alias mp='mplayer'
alias mon='bmon -p wlan0'
alias py='ipython'
alias s='sudo'
#switch to specified user's environment, making su safer.
alias su='su -l'
alias t='htop'
alias tp='type'
alias tpa='type -a'
alias v='vim'
alias vd='vimdiff'
alias vi='vim'
alias vim='vim -p'
alias wh='which'
# '-w' means supporting wild-cards
alias what='whatis -w'
alias where='whereis'
alias x='xargs'
alias x0='xargs -0'

# find is made easier
# [1] do not descend onto other filesystems
# [2] only consider normal file
alias f='find . -mount -type f'

# make vim-fans feel at home when using viewing info pages
alias info='info --vi-keys'

#---------------------------------------------------------------------------#
#                                  misc alias                               #
#---------------------------------------------------------------------------#

# ranger is my favorite console-baese filemanager
alias r='ranger'

# also copy the higher hierarchry
alias cpp='cp --parents'

# create missing parent folder, if necessary
alias mkdir='mkdir -p'


# ack-grep is a better grep!
# alias it to ack  only if it is installed as ack-grep
which ack-grep >/dev/null 2>&1  &&  alias ack=ack-grep

# generated unified  result
alias diff='diff -aruN'

alias cdiff='colordiff'

alias svn-versionalize="svn status |grep '\?' |awk '{print $2}'| xargs svn add"
alias svndiff='svn diff -diff-cmd=colordiff'

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
#alias dict='diction -b -s -L en'

alias em='emacs'
# lanuch the console version of emacs
alias emc='emacs -nw'

alias aml='tail ~/.aMule/logfile'

# prevent typo
alias mr='rm'
alias vm='mv'

# create subfolder with the same name, if necessary, before extracting
alias unp='dtrx --recursive --one-entry=here'
alias unpl='dtrx --list'
#alias unps='unp -u'

# -r            recursive
# -t            preserve modification timestamp
# -p            preserve permission
# -E            preserve executability
# -l            copy symlink itself
# -x            one file system, not crossing FS border
# -v            verbose
# --progress    show progress
# --spars       handle sparse file efficiently
alias rsync='rsync -r -t -p -E -l -x -v --progress --sparse'

# always force tmux to assume 256-color terminal
alias tmux='tmux -2'

# print the mime type of specified files
alias mime='file -i'

# case-insensitve by default
alias locate='locate -i'

# show 3 months's calendar
alias cal='cal -3m'

#---------------------------------------------------------------------------#
#                                   git alias                               #
#---------------------------------------------------------------------------#

# bash aliases for git aliases! lazy is good virture!

alias ad='git add'
alias lg='git lg'
alias co='git co'
alias st='git status'
alias cm='git cm'
alias br='git br'
alias cma='git cma'
alias bra='git bra'
alias dff='git df'
alias pull='git pull'
alias push='git push'
#  -x    append extra note recording the original commit
alias pick='git cherry-pick -x '
alias amend='git amend'
alias fetch='git fetch'
alias merge='git merge'
alias clone='git clone'
alias rebase='git rebase'
alias contain='git contain'
alias recover='git recover'
alias assume='git update-index --assume-unchanged'
alias noassume='git update-index --no-assume-unchanged'
alias assumed='git assumed'

