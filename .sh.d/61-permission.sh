#!/bin/sh

# fix inappropriate dir permission mode
function fix-dir-perm ()
{
    find . -type d \( -perm 700 -o -perm 500 -o -perm 555 \) -exec chmod 755 {} \;
}

# fix inappropriate file permission mode
function fix-file-perm ()
{
    find . -type f \( -perm 400 -o -perm 444 \) -exec chmod 644 {} \;
}
