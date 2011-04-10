# ~/.zshrc: executed by zsh(1) for non-login interacvive-shells.

# If not running interactively, do nothing
[ -z "$PS1" ] && return

source ~/.shrc

# zsh-specific settings
export PRIVATE_ZSH_DIR=$HOME/.zsh.d
Source "$PRIVATE_ZSH_DIR/zsh.zsh"
Source "$PRIVATE_ZSH_DIR/test.zsh"


