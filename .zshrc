# Created by newuser for 4.3.6

# auto correct spelling mistake
setopt CORRECT

#----------------------------------------------------------------------------------------
# set prompt
#----------------------------------------------------------------------------------------
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
    setopt promptsubst
    unsetopt transient_rprompt # leave the pwd

    precmd()  {
        set_prompt
        print -Pn "\e]0;%n@$__IP:%l\a"
    }

    PS1=$'$C_L_BLUE%(1j.[$myjobs]% $C_OFF .$C_OFF)%m.%B%n%b$C_OFF$C_L_RED%#$C_OFF'


    # use vi-mode for input
    bindkey -v

    # add the feature of showing current vi mode: insert? normal?
    source ~/.zsh.d/prompt-current-vi-mode.zsh
