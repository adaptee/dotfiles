#!/bin/sh

#---------------------------------------------------------------------------#
#                                   Others                                  #
#---------------------------------------------------------------------------#

alias a='alias'
alias c='cl'

# show date in pretty format.
alias dt='date "+%Y-%m-%d %A    %T %Z"'

alias fl='file'
alias h='help'
alias io='sudo iotop -o'
alias m='man'
alias ma='man -a'
alias mf='man -f'
alias mm='man man'
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

# make the output of diff more friendly
alias diff='diff --text --unified=3 --recursive --new-file'

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

