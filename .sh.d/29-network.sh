#!/bin/sh


#---------------------------------------------------------------------------#
#                                network alias                              #
#---------------------------------------------------------------------------#

alias pi='pinger --quiet'

alias dns='cat /etc/resolv.conf'

alias fping='fping -a'

# show numeric ip address
#alias arp='arp -n'

# this is much simpler than command arp
alias arp='cat /proc/net/arp | grep -v "00:00:00:00:00:00" '


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

alias get='wget -c'
