#!/bin/bash

export LC_CTYPE=zh_CN.gbk
export LC_CHARSET=GBK 

alias ls='/bin/ls --show-control-chars'

alias less='less --raw-control-chars'
export LESSCHARSET=iso8859

proxy='http://10.35.33.10:80'
export http_proxy=${proxy}
export HTTP_PROXY=${proxy}
