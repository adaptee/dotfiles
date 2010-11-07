
#----------------------------------------------------------------------------------------
#                                       options
#----------------------------------------------------------------------------------------

#----- Changing Directories

# Make cd push the old directory onto the directory stack.
setopt auto_pushd

setopt auto_cd

setopt cdable_vars

# Have pushd with no arguments act like `pushd $HOME'.
setopt pushd_to_home

# setopt auto_pushd
setopt pushd_ignore_dups

#----- Completion

setopt always_to_end

# Lay out the matches in completion lists sorted horizontally
setopt list_rows_first

# override auto_menu
setopt menu_complete

#----- Expansion and Globbing

# show warning about bad globbing pattern
setopt bad_pattern

setopt extended_glob

# If a pattern for filename generation has no matches, print an error
setopt nomatch


# If numeric filenames are matched by a filename generation pattern,
# sort the filenames numerically rather than lexicographically.
setopt numeric_glob_sort


# ----- History


# ----- Input/Output

# auto correct spelling mistake
setopt correct
setopt correct_all

# allow input comments in interactive shell
setopt interactive_comments

#setopt print_exit_value

#setopt rm_star_silent


# ----- Job control

# Run all background jobs at a lower priority
setopt bg_nice


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
bindkey -M vicmd '#' vi-pound-insert

# use 'Alt-k' to insert the last word of previous command
bindkey -M viins '\M-k' insert-last-word

# complete by history command match current head
bindkey -M viins '^k' history-beginning-search-backward

# use emacs-mode keybindings
#bindkey -e


#----------------------------------------------------------------------------------------
#                                       History
#----------------------------------------------------------------------------------------

HISTSIZE=50000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh.d/history

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

#%D{%L:%M}

# enable parameter expansion, command substitution and arithmetic expansion
# within prompt.
setopt prompt_subst

# get the colors
autoload colors zsh/terminfo

if [[ "$terminfo[colors]" -ge 8 ]]; then
    colors
fi

for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE GREY; do
    eval C_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
    eval C_L_$color='%{$fg[${(L)color}]%}'
done

C_OFF="%{$terminfo[sgr0]%}"

# set the prompt

set_prompt()
{

    mypath="$C_OFF$C_L_GREEN%~"

    myjobs=()

    for a (${(k)jobstates})
        {
            j=$jobstates[$a];
            i="${${(@s,:,)j}[2]}"
            myjobs+=($a${i//[^+-]/})
        }

        myjobs=${(j:,:)myjobs}
        ((MAXMID=$COLUMNS / 2)) # truncate to this value
        RPS1="$RPSL$C_L_GREEN%$MAXMID<...<$mypath$RPSR"

        rehash

    }

    RPSL=$'$C_OFF'
    RPSR=$'$C_OFF$C_L_RED%(0?.$C_L_GREEN. (%?%))$C_OFF'
    RPS2='%^'

    # load prompt functions
    setopt prompt_subst
    unsetopt transient_rprompt # leave the pwd

    precmd()  {
        set_prompt
        print -Pn "\e]0;%n@$__IP:%l\a"
    }

    PS1=$'$C_L_BLUE%(1j.[$myjobs]% $C_OFF .$C_OFF)%m.%B%n%b$C_OFF$C_L_RED%#$C_OFF'


# add the feature of showing current vi mode: insert? normal?
Source $PRIVATE_ZSH_DIR/prompt-current-vi-mode.zsh


#----------------------------------------------------------------------------------------
#                                           Completion
#----------------------------------------------------------------------------------------

# turn on powerful tab-completion
autoload -U compinit
compinit

#----------------------------------------------------------------------------------------
#                                           MIME Association
#----------------------------------------------------------------------------------------

# open file without prefixing command
autoload -U zsh-mime-setup
zsh-mime-setup

# open .avi and .mkv with mplayer
alias -s avi=mplayer
alias -s mkv=mplayer
alias -s flac=deadbeef






