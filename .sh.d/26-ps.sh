#!/bin/sh


#---------------------------------------------------------------------------#
#                                process alias                              #
#---------------------------------------------------------------------------#

# customize the displaying layout for command ps.
alias ps='ps -o user,pid,ppid,%cpu,%mem,vsz,rss,tty,stat,pri,wchan,start,time,args -w '

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
alias kam='killall -9 mplayer'


#kill all background jobs
alias kajobs='kill "$@" $(jobs -p)'

# pause specified process.
alias pause='kill -STOP'

# list all jobs with its process id.
alias jobs='jobs -l'

# kill whatever process who is occupying specified file.
alias release='fuser -k'


# grep the result of ps
# Usage: psg [CMD-NAME]
# Tip: [\1]  is used to exclude grep from the final result
function psg()
{
    target=$(echo $1 | sed "s/^\(.\)/[\1]/g")
    command=$(echo "COMMAND" | sed "s/^\(.\)/[\1]/g")
    #ps auxw | grep -E "$(echo $1 | sed "s/^\(.\)/[\1]/g")"
    ps -axw | grep -i -E "$target|$command"
}
