
#----------------------------------------------------------------------------------------
#                                       options
#----------------------------------------------------------------------------------------

#----- Changing Directories ----- #

# Make cd push the old directory onto the directory stack.
setopt auto_pushd
setopt pushd_ignore_dups
# Have pushd with no arguments act like `pushd $HOME'.
setopt pushd_to_home

setopt auto_cd

setopt cdable_vars

# expand path acronyms
# cd /v/c/p/p<TAB>  => /var/cache/pacman/pkg
setopt complete_in_word


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

# show the exit code when a command  fails
setopt print_exit_value

# no not ask for confirm before executing 'rm *'
setopt rm_star_silent


# ----- Job control
# Report the status of background and suspended jobs before exiting a shell
# a second  attempt to  exit  the shell will succeed.
setopt check_jobs


# Run all background jobs at a lower priority
setopt bg_nice

# show pid in bg job list
setopt long_list_jobs

# do not report finished jobs immediately
setopt no_notify

# do not send SIGHUP to background jobs when shell exits
setopt no_hup

# ----- Scripts and Functions
# Output hexadecimal numbers in standard C format,
# for example, show `0xFF' instead of the default 16#FF'
setopt c_bases

# make the precedence of arithmetic operators to be more like C
setopt c_precedences

# just shut up
setopt no_beep

#Perform implicit tees or cats when multiple redirections are attempted
setopt multios

# limit the modification to options and traps local to function
#setopt local_options local_traps

#----------------------------------------------------------------------------------------
#                                       Keybindings
#----------------------------------------------------------------------------------------

# shorten the default keyboard timeout
# unit: 1/100 s
KEYTIMEOUT=20

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
bindkey -M vicmd 'H' vi-first-non-blank
bindkey -M vicmd 'L'  vi-end-of-line

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

#autoload -U url-quote-magic
#zle -N self-insert url-quote-magic


## set command prediction from history, see 'man 1 zshcontrib'
autoload  zle/predict-on && \
zle -N predict-on         && \
zle -N predict-off        && \
bindkey "^X^o" predict-on && \
bindkey "^X^f" predict-off


# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
autoload -U zkbd
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


# colorize command as blue if found in path or defined.
# stolen from git://github.com/roylez/dotfiles.git
TOKENS_FOLLOWED_BY_COMMANDS=('|' '||' ';' '&' '&&' 'sudo' 'do' 'time' 'strace')

recolor-cmd() {
    region_highlight=()
    colorize=true
    start_pos=0
    for arg in ${(z)BUFFER}; do
        ((start_pos+=${#BUFFER[$start_pos+1,-1]}-${#${BUFFER[$start_pos+1,-1]## #}}))
        ((end_pos=$start_pos+${#arg}))
        if $colorize; then
            colorize=false
            res=$(LC_ALL=C builtin type $arg 2>/dev/null)
            case $res in
                *'reserved word'*)   style="fg=magenta,bold";;
                *'alias for'*)       style="fg=cyan,bold";;
                *'shell builtin'*)   style="fg=yellow,bold";;
                *'shell function'*)  style='fg=green,bold';;
                *"$arg is"*)
                    [[ $arg = 'sudo' ]] && style="fg=red,bold" || style="fg=blue,bold";;
                *)                   style='none,bold';;
            esac
            region_highlight+=("$start_pos $end_pos $style")
        fi
        [[ ${${TOKENS_FOLLOWED_BY_COMMANDS[(r)${arg//|/\|}]}:+yes} = 'yes' ]] && colorize=true
        start_pos=$end_pos
    done
}

check-cmd-self-insert() { zle .self-insert && recolor-cmd }
check-cmd-backward-delete-char() { zle .backward-delete-char && recolor-cmd }

zle -N self-insert check-cmd-self-insert
zle -N backward-delete-char check-cmd-backward-delete-char

# insert 'sudo' at the front of command-line
function sudo-command-line()
{
    [[ -z $BUFFER ]] && zle up-history
    [[ $BUFFER != sudo\ * ]] && BUFFER="sudo $BUFFER"
    zle end-of-line # move cursor to the end
    #zle vi-end-of-line
}
zle -N sudo-command-line
bindkey "\es" sudo-command-line

# use 'Ctrl-k' to insert the last word of previous command
#bindkey -M viins '^k' insert-last-word
#bindkey -M vicmd '^k' insert-last-word

# complete history command by matching current head
#bindkey -M viins '^j' history-beginning-search-backward
#bindkey -M vicmd '^j' history-beginning-search-backward

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

# do not execute the result of history expansion immeditely
set hist_very



#----------------------------------------------------------------------------------------
#                                           Prompt
#----------------------------------------------------------------------------------------

# setup my prompt
Source $PRIVATE_ZSH_DIR/prompt.zsh

#----------------------------------------------------------------------------------------
#                                           Completion
#----------------------------------------------------------------------------------------

# turn on powerful tab-completion
autoload -U compinit
compinit

# should be include before using keymap 'menuselect'
zmodload zsh/complist

# general option( I do not know what they do, yet)
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
#zstyle ':completion:*:*:default' force-list always
zstyle ':completion:*' select-prompt '%SSelect:  lines: %L  matches: %M  [%p]'

# cache the result of completion
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh.d/cache

## use vi navigation keys (hjkl) in menu completion
bindkey -M menuselect 'h' vi-backward-char        # left
bindkey -M menuselect 'k' vi-up-line-or-history   # up
bindkey -M menuselect 'l' vi-forward-char         # right
bindkey -M menuselect 'j' vi-down-line-or-history # bottom


# tune path completion
zstyle ':completion:*' expand 'yes'
zstyle ':completion:*' squeeze-shlashes 'yes'
zstyle ':completion::complete:*' '\\'

# make completion menu colorful
eval $(dircolors -b)
export ZLSCOLORS="${LS_COLORS}"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# in completion menu, show catetory info about candicates
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:descriptions' format $'\e[01;33m -- %d --\e[0m'
zstyle ':completion:*:messages' format $'\e[01;35m -- %d --\e[0m'
zstyle ':completion:*:warnings' format $'\e[01;31m -- No Matches Found --\e[0m'
zstyle ':completion:*:corrections' format $'\e[01;32m -- %d (errors: %e) --\e[0m'

## case-insensitive (uppercase from lowercase) completion
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}'
## case-insensitive (all) completion
#zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# correct typo
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# killing is so sexy and easy now!
zstyle ':completion:*:*:kill:*' menu yes select
#zstyle ':completion:*:*:*:*:processes' force-list always
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors "=(#b) #([0-9]#)*=36=1;31"

# completion for ping
zstyle ':completion:*:ping:*' hosts douban.com 192.168.1.{1,2,3,10,14}

# completion for ssh, scp, etc
my_accounts=(
whodare@192.168.1.37
adaptee@gmail.com
)
zstyle ':completion:*:my-accounts' users-hosts $my_accounts

# force rehash when command not found
# http://zshwiki.org/home/examples/compsys/general
_force_rehash() {
    (( CURRENT == 1 )) && rehash
    return 1    # Because we did not really complete anything
}


# support chsdir, which provide pinyin-based completion for chinese characters
function _pinyin()
{
    # chsdir print one candidate per line
    # this looks weird, bug IFS='\n' does not work in interactive shell
    local IFS=$'\n'

    reply=($(chsdir 0 $*))
}

zstyle ':completion:*' user-expand _pinyin
# omit origianl
zstyle ':completion:*:user-expand:*' tag-order '!original'

zstyle ':completion:*' completer _oldlist _expand _force_rehash _complete _match _user_expand

#----------------------------------------------------------------------------------------
#                                           Aliases
#----------------------------------------------------------------------------------------

# zsh's 'type' is not that powerful; whence is the one you need
alias tp='whence -f'
alias tpa='whence -fca'

# what commands do you use most often?
alias topcmd='print -l ${(o)history%% *} | uniq -c | sort -nr | head -n 20'

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

# setup suffix aliases automatically, according to existing MIME info
# in /etc/mailcap and /etc/mime.types
autoload -U zsh-mime-setup  && zsh-mime-setup

# setup suffix aliases, manually
for i in jpg jpeg png svg bmp;              alias -s $i=gwenview
for i in mp3 wma ogg flac ape tta wv wav;   alias -s $i=deadbeef
for i in avi rmvb wmv mkv mp4;              alias -s $i=mplayer
for i in rar zip gz 7z xz lzma;             alias -s $i=unp
for i in txt list cue conf log;             alias -s $i=vim


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
WORDCHARS="${WORDCHARS:s#/#}"
WORDCHARS="${WORDCHARS:s#.#}"
#WORDCHARS='*?_-[]~=&;!#$%^(){}<>'

# colorize the spelling prompt
SPROMPT="${FG_YELLOW}zsh${NOCOLOR}: correct '${FG_BD_RED}%R${NOCOLOR}' to '${FG_BD_GREEN}%r${NOCOLOR}' ? ([${FG_CYAN}Y${NOCOLOR}]es/[${FG_CYAN}N${NOCOLOR}]o/[${FG_CYAN}E${NOCOLOR}]dit/[${FG_CYAN}A${NOCOLOR}]bort) "

# highlight chars or regions of the cmdline that have a particular  significance.
zle_highlight=( region:bg=magenta
                special:bold,fg=magenta
                default:bold
                isearch:underline
              )


#show 256 color tab
# stolen from git://github.com/roylez/dotfiles.git
256tab() {
    for k in `seq 0 1`;do
        for j in `seq $((16+k*18)) 36 $((196+k*18))`;do
            for i in `seq $j $((j+17))`; do
                printf "\e[01;$1;38;5;%sm%4s" $i $i;
            done;echo;
        done;
    done
}

# we needs an history function that is similar to  bash's
function history ()
{
    fc -l -i 1
}

# Switching shell safely and efficiently?
# http://www.zsh.org/mla/workers/2001/msg02410.html
bash() {
   NO_SWITCH="yes" command bash "$@"
}
