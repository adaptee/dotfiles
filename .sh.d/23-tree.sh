#!/bin/sh

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
