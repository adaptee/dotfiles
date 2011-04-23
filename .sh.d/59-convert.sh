#!/bin/sh

#---------------------------------------------------------------------------#
#                               converting utility                          #
#---------------------------------------------------------------------------#

# convert single pdf file to png files, one png file per one page
# usage: pdf2png xxxx.pdf
function pdf2png()
{
    convert -quality 100 -antialias -density 96 -transparent white -trim $1 \
    $( basename $1 '.pdf')".png"
}

function dir2iso()
{
    if [[ $# != 2 ]] ; then
        echo "Usage: dir2iso [folder-name] [iso-label] "
        return 1
    fi

    local folder="$1"
    local iso_label="$2"

    #genisoimage -r -J -joliet-long -input-charset utf-8 -hide boot.catalog -hide-joliet boot.catalog -V "${iso_label}" -o "${iso_label}.iso" "${folder}"
    mkisofs -r -J -joliet-long -input-charset utf-8 -hide boot.catalog -hide-joliet boot.catalog -V "${iso_label}" -o "${iso_label}.iso" "${folder}"

}

# convert manpages to plain text file
# usage: man2txt command...
function man2txt()
{
    local item
    for item in "$@";do
        man ${item} | col -b >"${item}.txt"
    done
}

# convert manpages to pdf file
# usage: man2pdf command...
function man2pdf()
{
    local item
    for item in "$@";do
        man -t ${item} | ps2pdf - >"${item}.pdf"
    done
}
