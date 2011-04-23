#!/bin/sh

#---------------------------------------------------------------------------#
#                               encoding utility                            #
#---------------------------------------------------------------------------#

# convert filename to UTF-8 encoding
# usage convmv-utf8 FILES....
function convmv-utf8 ()
{
    convmv -f gbk -t utf-8 --notest "$@"
}

# transform from gb* encoding to utf-8; old file is automatically renamed
# usage: gb2u8 files...
function gb2u8()
{
    local item
    for item in "$@";do
        if  enca "${item}" | grep -i 'GB2312\|Unrecognize' >/dev/null  ; then

            iconv -f gb18030  -t utf8 -c "${item}" > "${item}.new"  &&  \
            mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"

            echo "${item} is converted into utf-8 encoding"
        fi
    done
}

# transform from utf-8 encoding to gb*; old file is automatically renamed
# usage: u82gb files...
function u82gb()
{
    local item

    for item in "$@";do
        if echo $(enca "${item}" ) | grep -i "UTF-8" >/dev/null ; then

            iconv -f utf8 -t gb18030  -c "${item}" > "${item}.new"  &&  \
            mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"

            echo "${item} is converted into gbk encoding."
        fi
    done

}

# transform from utf-16 encoding into utf-8; old file is automatically renamed
# usage: u162u8 files...
function u162u8()
{
    local item

    for item in "$@";do
        if echo $(enca "${item}" ) | grep -i "UCS-2" >/dev/null ; then

            iconv -f utf16 -t utf8  -c "${item}" > "${item}.new"  &&
            \mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"

            echo "${item} is converted into utf-8 encoding."
        fi
    done
}

# transform from utf-16 encoding into gbk; old file is automatically renamed
# usage: u162gb files...
function u162gb()
{
    local item

    for item in "$@";do
        if echo $(enca "${item}" ) | grep -i "UCS-2" >/dev/null ; then

            iconv -f utf16 -t gb18030  -c "${item}" > "${item}.new"  &&
            \mv "${item}" "${item}.old"  &&   mv "${item}.new" "${item}"

            echo "${item} is converted into utf-16 encoding."
        fi
    done
}
