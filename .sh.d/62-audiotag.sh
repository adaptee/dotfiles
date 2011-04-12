#!/bin/sh

# normalize and clear bad info within mp3 id3 tag
function cleanid3 ()
{
    find . -type f -iname '*.mp3' -print0 | xargs -0 id3clean
    find . -type f -iname '*.mp3' -print0 | xargs -0 mid3iconv -e gbk
}


# better than the obsolete id3info command
function id3info()
{
    mid3v2 -l "$1"
}

# list metadata of flac file
function flacinfo()
{
    metaflac --list "$1"
}
