#!/bin/sh

# often the next command after 'cd' is 'ls', so why not combine into one?
# usage: cl PATH
function cl() { cd "${@:-$HOME}" && ls; }

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

alias p='pwd'
alias pu='pushd'
alias po='popd'

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

