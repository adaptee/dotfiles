#!/bin/sh

# show current folder's git branch info
function parse_git_branch()
{
    # tell 'cut' to use SPACE as delimiter
    git branch 2> /dev/null | sed -e '/^[^*]/d' | cut -f 2 -d ' '
}

#---------------------------------------------------------------------------#
#                                   git alias                               #
#---------------------------------------------------------------------------#

# bash aliases for git aliases! lazy is good virture!

alias ad='git add'
alias lg='git lg'
alias co='git co'
alias cob='git cob'
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
