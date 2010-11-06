# If not running interactively, do nothing
[ -z "$PS1" ] && return

# source specified file, only when it really exist.
Source ()
{
    local item

    for item in "$@" ; do
        if [ -f "${item}" ] ; then
            source "${item}"
        else
            :
            #echo "[error] file '${item}' does not exist."
        fi
    done
}

export PRIVATE_SHELL_DIR=$HOME/.sh.d
export PRIVATE_ZSH_DIR=$HOME/.zsh.d

# auto correct spelling mistake
setopt correct
setopt correct_all

setopt no_beep
setopt auto_cd
setopt extended_glob
setopt multios

setopt pushd_ignore_dups
#setopt auto_pushd

# use vi-mode for input
bindkey -v



#----------------------------------------------------------------------------------------
#                                       History
#----------------------------------------------------------------------------------------

HISTSIZE=50000
SAVEHIST=$HISTSIZE
HISTFILE=~/.zsh.d/history

setopt append_history
setopt inc_append_history
setopt share_history

setopt extended_history

setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_find_no_dups

setopt no_hist_beep


#----------------------------------------------------------------------------------------
#                                           Prompt
#----------------------------------------------------------------------------------------

#%D{%L:%M}

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
            j=$jobstates[$a];i="${${(@s,:,)j}[2]}"
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


##############################################################################




# turn on powerful tab-completion
autoload -U compinit
compinit

# turn on powerful pormpt system
autoload -U promptinit
promptinit

# Completion style improvements
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

##############################################################################


Source "$PRIVATE_SHELL_DIR/alias.sh"
Source "$PRIVATE_SHELL_DIR/function.sh"

if [[ $(uname) =~ 'Linux'  ]] ; then

    distro=$(distro-detect)

    if [[ ${distro} != "unknown"  ]] ; then
        Source "${PRIVATE_SHELL_DIR}/${distro}.sh"
    fi

elif [[ $(uname) =~ 'Cygwin' ]] ; then
    Source "$PRIVATE_SHELL_DIR/cygwin.sh"
fi

Source "$PRIVATE_ZSH_DIR/zsh.zsh"
Source "$PRIVATE_SHELL_DIR/test.sh"

