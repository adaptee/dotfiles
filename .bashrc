# ~/.bashrc: executed by bash(1) for non-login interacvive-shells.

# If not running interactively, do nothing
[ -z "$PS1" ] && return

source ~/.shrc

# bash specific stuff
export PRIVATE_BASH_DIR=$HOME/.bash.d
Source "$PRIVATE_BASH_DIR/bash.bash"
Source "$PRIVATE_BASH_DIR/test.bash"
