
#----------------------------------------------------------------------------------------
#                                       options
#----------------------------------------------------------------------------------------

#----- Changing Directories ----- #

# Make cd push the old directory onto the directory stack.
setopt auto_pushd

setopt auto_cd

setopt cdable_vars

# Have pushd with no arguments act like `pushd $HOME'.
setopt pushd_to_home

# setopt auto_pushd
setopt pushd_ignore_dups

#----- Completion ----- #

setopt always_to_end

# Lay out the matches in completion lists sorted horizontally
setopt list_rows_first

# override auto_menu
setopt menu_complete

#----- Expansion and Globbing ---- #

# show warning about bad globbing pattern
setopt bad_pattern

setopt extended_glob

# make globbing case-insensitve
unsetopt case_glob

# If a pattern for filename generation has no matches, print an error
setopt nomatch

# If numeric filenames are matched by a filename generation pattern,
# sort the filenames numerically rather than lexicographically.
setopt numeric_glob_sort

# ----- Input/Output

# auto correct mis-spoken command-name
setopt correct
# also try to correct arguemnts
setopt correct_all

# allow input comments in interactive shell
setopt interactive_comments

#show the exit code when a command  fails
setopt print_exit_value

#setopt rm_star_silent


# ----- Job control

# Run all background jobs at a lower priority
setopt bg_nice

# show pid in bg job list
setopt long_list_jobs

# ----- Scripts and Functions
# Output hexadecimal numbers in standard C format,
# for example, show `0xFF' instead of the default 16#FF'
setopt c_bases

# make the precedence of arithmetic operators to be more like C
setopt c_precedences

setopt no_beep
setopt multios

#----------------------------------------------------------------------------------------
#                                       Keybindings
#----------------------------------------------------------------------------------------


# use vi-mode keybindings
bindkey -v

# use Ctrl-R to search histroy, backwardly and incrementally
bindkey -M viins '^r' history-incremental-search-backward
bindkey -M vicmd '^r' history-incremental-search-backward

# move the head/tail more quickly
#bindkey -M vicmd H  vi-beginning-of-line
bindkey -M vicmd H  vi-first-non-blank
bindkey -M vicmd L  vi-beginning-of-line

# comment/uncomment quickly
bindkey -M viins '\e3' vi-pound-insert
bindkey -M vicmd '#' vi-pound-insert

# work-aroung of failing "\M-k"
bindkey -M viins "\ek" insert-last-word
bindkey -M vicmd "\ek" insert-last-word

# work-aroung of failing "\M-j"
bindkey -M viins "\ej" history-beginning-search-backward
bindkey -M vicmd "\ej" history-beginning-search-backward

# stop editing; execute the command
bindkey -M viins "\em" accept-line
bindkey -M vicmd "\em" accept-line

# move backword by one char, in insert mode
bindkey -M viins -s "\eh" "\\ei"
# move forward by one char, in insert mode
bindkey -M viins -s "\el" "\\e[C"

# insert a pair of ``, "", ''
bindkey -M viins -s '\e`' \`\`\\ei
bindkey -M viins -s "\e;" \"\"\\ei
bindkey -M viins -s "\e'" \'\'\\ei

# use 'Ctrl-k' to insert the last word of previous command
#bindkey -M viins '^k' insert-last-word
#bindkey -M vicmd '^k' insert-last-word

# complete history command by matching current head
#bindkey -M viins '^j' history-beginning-search-backward
#bindkey -M vicmd '^j' history-beginning-search-backward

# use emacs-mode keybindings
#bindkey -e


#----------------------------------------------------------------------------------------
#                                       History
#----------------------------------------------------------------------------------------

HISTSIZE=50000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh.d/data/history

setopt append_history
setopt inc_append_history
setopt share_history

# Save  command's  timestamp  and duration (in seconds) to the history file
setopt extended_history

setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups

setopt no_hist_beep



#----------------------------------------------------------------------------------------
#                                           Prompt
#----------------------------------------------------------------------------------------

# turn on powerful pormpt system
autoload -U promptinit
promptinit

# enable parameter expansion, command substitution and arithmetic expansion
# within prompt.
setopt prompt_subst

# Remove right prompt from display when accepting a command line
#setopt transient_rprompt

# which prompt to use?
#Source $PRIVATE_ZSH_DIR/prompt-current-vi-mode.zsh
Source $PRIVATE_ZSH_DIR/nice-prompt.zsh
#Source $PRIVATE_ZSH_DIR/ugly-prompt.zsh

#----------------------------------------------------------------------------------------
#                                           Completion
#----------------------------------------------------------------------------------------

# turn on powerful tab-completion
autoload -U compinit
compinit

# cache the result of completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache


#----------------------------------------------------------------------------------------
#                                           MIME Association
#----------------------------------------------------------------------------------------

# show ls -F style marks in file completion
setopt list_types

# open file without prefixing command
autoload -U zsh-mime-setup
zsh-mime-setup


# open .avi and .mkv with mplayer
alias -s flac=deadbeef
alias -s txt=vim

for i in jpg jpeg png svg;                  alias -s $i=gwenview
for i in mp3 wma ogg flac ape tta wv wav;   alias -s $i=deadbeef
for i in avi rmvb wmv mkv mp4;              alias -s $i=mplayer
for i in rar zip gz 7z xz lzma;                alias -s $i=unp


#----------------------------------------------------------------------------------------
#                                           Global aliases
#----------------------------------------------------------------------------------------
#
alias -g A="|awk"
# removing ANSI color code from stdin
alias -g B='| sed -r "s:\x1B\[[0-9;]*[mK]::g"'
alias -g C='| column -t'
alias -g E='| sed'
alias -g G='| gi'
alias -g H="| head -n $(($LINES-2))"
alias -g H='| head'
alias -g L='| less'
alias -g N="> /dev/null"

# global alias for matching the latest modified item
# o     : sort
# c     : sort by modification time of inode
# [1]   : show only one match
alias -g NF="./*(oc[1])"

alias -g R='| tac'
alias -g S='| sort'
alias -g T="| tail -n $(($LINES-2))"
alias -g V='| vim -'
alias -g W='| wc -l'
alias -g X='| xargs '
alias -g X0='| xargs -0'

#----------------------------------------------------------------------------------------
#                                           VCS info
#----------------------------------------------------------------------------------------

# load vcs_info:
autoload -Uz vcs_info

#----------------------------------------------------------------------------------------
#                                           Environment
#----------------------------------------------------------------------------------------

cdpath=(~ ~/code ~/down ~/audio)

# less is better than more!
export READNULLCMD=less

# remove duplicataed entry within PATH
typeset -U PATH
