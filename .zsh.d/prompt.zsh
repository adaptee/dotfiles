# http://matija.suklje.name/?q=node/207

# Enables additional prompt extentions
setopt prompt_subst

# Enables colours
autoload -U colors && colors
autoload -U zsh/terminfo

# get info about VCS (e.g. Git, Subversion, Mercurial
autoload -Uz vcs_info

# wrapper colors %{...%}.
PR_NOCOLOR="%{$reset_color%}"
for COLOR in RED GREEN YELLOW BLUE CYAN MAGENTA WHITE BLACK; do

    #eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
    #eval PR_BD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'

    eval PR_$COLOR='%{$fg[${(L)COLOR}]%}'
    eval PR_BD_$COLOR='%{$terminfo[bold]$fg[${(L)COLOR}]%}'

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
            PR_EXITCODE=${PR_BD_RED}\[$code\]${PR_NOCOLOR}
        else
            PR_EXITCODE=""
        fi

        if [[ -z $(git status -s 2> /dev/null) ]] {
                zstyle ':vcs_info:*' formats "${PR_CYAN}%s|%b ${PR_NOCOLOR}"
        } else {
                # red indicates 'modifications'
                zstyle ':vcs_info:*' formats "${PR_CYAN}%s|%b ${PR_BD_RED}●${PR_NOCOLOR}"
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
        PR_USERNAME=${PR_BD_RED}%n${PR_NOCOLOR}
        PR_SYMBOL=${PR_BD_RED}'#'${PR_NOCOLOR}
    else
        PR_USERNAME=${PR_BD_GREEN}%n${PR_NOCOLOR}
        PR_SYMBOL=${PR_BD_GREEN}'$'${PR_NOCOLOR}
    fi

    PR_HOSTNAME="unknown"
    if [ -n "$SSH_TTY" ]; then
        # highlight by red for ssh session.
        PR_HOSTNAME=${PR_BD_RED}%m${PR_NOCOLOR}
    else
        PR_HOSTNAME=${PR_BD_GREEN}%m${PR_NOCOLOR}
    fi

    PR_TTY="unknown"
    PR_TTY=${PR_YELLOW}%y${PR_NOCOLOR}

    PR_PWD="unknown"
    PR_PWD=${PR_BD_CYAN}%~${PR_NOCOLOR}

    # default prompt
    PS1='${PR_USERNAME}@${PR_HOSTNAME} on ${PR_TTY} in ${PR_PWD} ${ZLEVIMODE}
{${vcs_info_msg_0_}} ${PR_EXITCODE} ${PR_SYMBOL} '

    # default prompt's right side
    # show date and time
    # [format] hh:mm year-month-day weekday
    RPS1='${PR_CYAN}%D{%H:%M %Y-%m-%d %a}${PR_NOCOLOR}'

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
