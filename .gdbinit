# make prompt more clear
set prompt \033[01;31m gdb$ \033[0m

# Remember history across restarts
set history save

# Make gdb stop paging
set height 0

# Make gdb display full strings
set print elements 0

# Make gdb pretty print variables
set print pretty on

source ~/.gdb.d/kde-devel.gdb

