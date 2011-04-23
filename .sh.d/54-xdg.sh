#!/bin/sh

# open specified files with appropriate programs
# usage: go FILES...
function go ()
{
    local item
    for item in "$@";do
        xdg-open "${item}"
    done
}

# empty the trash box
function trash-empty()
{
    command trash-empty && notify-send -i ~/.icons/trash.png "Trash is emptied."
}
