#!/bin/sh

# return the extension part of a filename
# input:  hello.world.I.love.linux.iso
# output: iso
function getextension()
{
    local filename="$1"
    echo ${filename##*.}
}

# remove the extension part of a filename
# input:  hello.world.I.love.linux.iso
# output: hello.world.I.love.linux
function trimextension()
{
    local filename="$1"
    echo ${filename%.*}
}
