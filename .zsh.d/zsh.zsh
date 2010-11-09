
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

# insert the first candidate immediately when ambigurious
#setopt menu_complete

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

# kill previous word
bindkey -M viins '^w' vi-backward-kill-word
# kill till EOL
bindkey -M viins '^k' vi-kill-eol

# move the head/tail more quickly
#bindkey -M vicmd H  vi-beginning-of-line
bindkey -M vicmd H  vi-first-non-blank
bindkey -M vicmd L  vi-end-of-line

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

# from linuxtoy: http://linuxtoy.org/archives/zsh_per_dir_hist.html
# pressing TAB in an empty command makes a cd command with completion list
dumb-cd(){
    if [[ -n $BUFFER ]] ; then  # if line is not empty
        zle expand-or-complete  # perform origial action of TAB
    else
        BUFFER="cd "            # insert 'cd'
        zle end-of-line         # move cursor to end-of-line
        zle expand-or-complete  # perform origial action of TAB
    fi
}

zle -N dumb-cd
bindkey "\t" dumb-cd


# bind 'Alt-e' to invoke external editor to edit cmdline
autoload -U edit-command-line
zle -N      edit-command-line
bindkey -M viins '\ee' edit-command-line
bindkey -M vicmd '\ee' edit-command-line

# Functions to make it easier to type URLs as command line arguments.  As
# you type, the input character is analyzed and, if it may need quoting,
# the current word is checked for a URI scheme.  If one is found and the
# current word is not already in quotes, a backslash is inserted before
# the input character.
autoload -U url-quote-magic
zle -N self-insert url-quote-magic


# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
autoload -U zkbd

#define an array
typeset -A key

#if zkbd definition exists, use defined keys instead
if [[ -f ~/.zkbd/${TERM}-${DISPLAY:-$VENDOR-$OSTYPE} ]]; then
    source ~/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE}
else
    key[Home]=${terminfo[khome]}
    key[End]=${terminfo[kend]}
    key[Insert]=${terminfo[kich1]}
    key[Delete]=${terminfo[kdch1]}
    key[Up]=${terminfo[kcuu1]}
    key[Down]=${terminfo[kcud1]}
    key[Left]=${terminfo[kcub1]}
    key[Right]=${terminfo[kcuf1]}
    key[PageUp]=${terminfo[kpp]}
    key[PageDown]=${terminfo[knp]}
    for k in ${(k)key} ; do
        # $terminfo[] entries are weird in ncurses application mode...
        [[ ${key[$k]} == $'\eO'* ]] && key[$k]=${key[$k]/O/[}
    done
fi

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char

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

# setup my prompt
Source $PRIVATE_ZSH_DIR/prompt.zsh

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
#                                           Aliases
#----------------------------------------------------------------------------------------

# zsh's 'type' is not that powerful; whence is the one you need
alias tp='whence -f'
alias tpa='whence -fca'

# show whole history
alias history='history 1'

# stop correction for mv, cp, mkdir
for i in mkdir mv cp;       alias $i="nocorrect $i"

# switch folder quickly
alias 1='cd -'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

#----------------------------------------------------------------------------------------
#                                           MIME Association
#----------------------------------------------------------------------------------------

# show ls -F style marks in file completion
setopt list_types

# open file without prefixing command
autoload -U zsh-mime-setup
zsh-mime-setup


# open .avi and .mkv with mplayer
alias -s txt=vim

for i in jpg jpeg png svg;                  alias -s $i=gwenview
for i in mp3 wma ogg flac ape tta wv wav;   alias -s $i=deadbeef
for i in avi rmvb wmv mkv mp4;              alias -s $i=mplayer
for i in rar zip gz 7z xz lzma;             alias -s $i=unp
for i in txt list cue conf sh zsh bash log; alias -s $i=vim


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
#                                           Environment
#----------------------------------------------------------------------------------------

# remove duplicataed entry within PATH
typeset -U PATH

# similar to CDPATH in bash
#cdpath=(  ~/code )

# less is better than more!
READNULLCMD=less

# remove / and . from default WORDCHARS
WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# colorize the prompt when asking correction
SPROMPT="${FG_YELLOW}zsh${NOCOLOR}: correct '${FG_BD_RED}%R${NOCOLOR}' to '${FG_BD_GREEN}%r${NOCOLOR}' ? ([${FG_CYAN}Y${NOCOLOR}]es/[${FG_CYAN}N${NOCOLOR}]o/[${FG_CYAN}E${NOCOLOR}]dit/[${FG_CYAN}A${NOCOLOR}]bort) "

# highlight chars or regions of the cmdline that have a particular  significance.
zle_highlight=( region:bg=magenta
                special:bold,fg=magenta
                default:bold
                isearch:underline
              )
