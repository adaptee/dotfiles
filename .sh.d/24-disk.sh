#!/bin/sh

#---------------------------------------------------------------------------#
#                         df & du & mount alias                             #
#---------------------------------------------------------------------------#

# df improved: show FS type, human-friendly size and ignore pseudo FS.
alias df='LANG=en df -h -T -x tmpfs | grep -vE "(tmpfs|gvfs|procbususb|rootfs|devtmpfs|debugfs)"'

# show the size of direct-subentry, and sort them in acednding order by size
alias du='command du -h --max-depth=1 --one-file-system |sort -h'

# show the total size
alias dus='command du -h -s --one-file-system'

# make the output of mount looks better
alias mount='mount | column -t'

#show currently mounted partition in nice layout
alias mnt='mount |grep -E "ext[2-4]|reiserfs|vfat|ntfs|xfs|jfs|zfs" |column -t'
# remount all partition.
alias mnta='sudo mount -a'
