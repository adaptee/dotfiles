#!/bin/sh

# make ranger utilize the optimization feature provided by ptyhon
# change $PWD to the last directory , after exiting ranger
function ranger() {
    PYTHONOPTIMIZE=1 command ranger --fail-if-run $@ && cd "$(grep \^\' ~/.config/ranger/bookmarks | cut -b3-)"
}
