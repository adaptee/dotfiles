# http://matija.suklje.name/?q=node/207

# Enables additional prompt extentions
setopt prompt_subst

# get info about VCS (e.g. Git, Subversion, Mercurial
autoload -Uz vcs_info

# Enables colours
autoload -U colors && colors
autoload -U zsh/terminfo

# wrapper colors %{...%}.
NOCOLOR="%{$reset_color%}"
for COLOR in RED GREEN YELLOW BLUE CYAN MAGENTA WHITE BLACK; do

    #eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
    #eval FG_BD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'

    eval FG_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval BG_$COLOR='%{$bg[${(L)COLOR}]%}'
    eval FG_BD_$COLOR='%{$terminfo[bold]$fg[${(L)COLOR}]%}'
    eval BG_BD_$COLOR='%{$terminfo[bold]$bg[${(L)COLOR}]%}'

done

# only intrested with these VCSs
zstyle ':vcs_info:*' enable git hg bzr

# decect the mode changing of zle in real time
# http://pthree.org/2009/03/28/add-vim-editing-mode-to-your-zsh-prompt/
function zle-line-init zle-keymap-select {
    ZLEVIMODE="${${KEYMAP/vicmd/-- NORMAL --}/(main|viins)/}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select


# this command will be excuted by ZSH befor showing prompt, each time
function precmd () {
        # this has to be done ahead of any other tasg.
        local code=$?
        if [[ $code != 0 ]]; then
            PR_EXITCODE=${FG_BD_RED}\[$code\]${NOCOLOR}
        else
            PR_EXITCODE=""
        fi

        if [[ -z $(git status -s 2> /dev/null) ]] {
                zstyle ':vcs_info:*' formats "${FG_CYAN}%s|%b ${NOCOLOR}"
        } else {
                # red indicates 'modifications'
                zstyle ':vcs_info:*' formats "${FG_CYAN}%s|%b ${FG_BD_RED}●${NOCOLOR}"
        }

        # after executing one command, zle is alawys in insert mode, isn't it?
        ZLEVIMODE=''

        vcs_info
}


function setupprompt() {

    PR_USERNAME="unknown"
    PR_SYMBOL="unknown"
    if [[ $USENAME == "root" ]] ; then
        # highlight by red for root.
        PR_USERNAME=${FG_BD_RED}%n${NOCOLOR}
        PR_SYMBOL=${FG_BD_RED}'#'${NOCOLOR}
    else
        PR_USERNAME=${FG_BD_GREEN}%n${NOCOLOR}
        PR_SYMBOL=${FG_BD_GREEN}'$'${NOCOLOR}
    fi

    PR_HOSTNAME="unknown"
    if [ -n "$SSH_TTY" ]; then
        # highlight by red for ssh session.
        PR_HOSTNAME=${FG_BD_RED}%m${NOCOLOR}
    else
        PR_HOSTNAME=${FG_BD_GREEN}%m${NOCOLOR}
    fi

    PR_TTY="unknown"
    PR_TTY=${FG_YELLOW}%y${NOCOLOR}

    PR_PWD="unknown"
    PR_PWD=${FG_BD_CYAN}%~${NOCOLOR}

    # default prompt
    PS1='${PR_USERNAME}@${PR_HOSTNAME} on ${PR_TTY} in ${PR_PWD} ${ZLEVIMODE}
{${vcs_info_msg_0_}} ${PR_EXITCODE} ${PR_SYMBOL} '

    # default prompt's right side
    # show date and time
    # [format] hh:mm year-month-day weekday
    RPS1='${FG_CYAN}%D{%H:%M %Y-%m-%d %a}${NOCOLOR}'

    # prompt for complex flow control, such as if, for and while.
    # '%_' will be replace with the parser's current state by zsh
    PS2='{%_} '

    #prompt for 'select' statement
    PS3='{ ... } '

    # So far I don't use "setopt xtrace", so I don't need this prompt
    # prompt for 'xtrace' option
    PS4='{%_} '

}

setupprompt
