# http://matija.suklje.name/?q=node/207

# Enables additional prompt extentions
setopt prompt_subst

# Enables colours
autoload -U colors && colors

# wrapper colors %{...%}.
for COLOR in RED GREEN YELLOW BLUE CYAN WHITE BLACK; do
    eval PR_$COLOR='%{$fg_no_bold[${(L)COLOR}]%}'
    eval PR_BD_$COLOR='%{$fg_bold[${(L)COLOR}]%}'
done

PR_NOCOLOR="%{$reset_color%}"



#PS1_EXITCODE='`a=$?;if [ $a -ne 0 ]; then echo -n -e "\['${BRIGHTRED}'\][$a]\['${NOCOLOR}'\]"; fi`'

# get info about VCS (e.g. Git, Subversion, Mercurial
autoload -Uz vcs_info

#zstyle ':vcs_info:*' stagedstr '%F{green}●%f'
#zstyle ':vcs_info:*' unstagedstr '%F{yellow}●%f'
#zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{red}:%f%F{yellow}%r%f'
zstyle ':vcs_info:*' enable git svn hg bzr

precmd () {
        #if [[ -z $(git ls-files --modified --exclude-standard 2> /dev/null) ]] {
        if [[ -z $(git status -s 2> /dev/null) ]] {
                #true
                zstyle ':vcs_info:*' formats '%F{cyan}[%s][%b]%f'
        } else {
                #true
                # red means 'unstaged modifications'
                zstyle ':vcs_info:*' formats '%F{cyan}[%s][%b]%F{red}●%f'
        }

        vcs_info
}

# which VCS is used ?
# who are you?
function prompt_char {
	#git branch >/dev/null 2>/dev/null && echo '±' && return
	#hg root >/dev/null 2>/dev/null && echo '☿' && return
	#svn info >/dev/null 2>/dev/null && echo '⚡' && return

        # return '%' for normal user, # for root
	echo '%#'
}

function pr_exitcode()
{
    local code=$?
    if [[ $code != 0 ]]; then
        echo '${PR_BD_RED}'\[$code\]'${reset_color}'
    fi
}
PR_EXITCODE=$(pr_exitcode)

function pr_username()
{
    if [[ $USENAME == "root" ]] ; then
        echo '${PR_BD_RED}%n${PR_NOCOLOR}'
    else
        echo '${PR_BD_GREEN}%n${PR_NOCOLOR}'
    fi
}

#if [[ "$UID" != "0" ]] ; then
    #PR_USERNAME='\['${PR_BD_GREEN}'\]'$USERNAME
    #PR_SYMBOL='\['${NOCOLOR}'\]''$ '
#else
    #PR_USERNAME='\['${PR_BD_RED}'\]'$USERNAME
    #PR_SYMBOL='\['${NOCOLOR}'\]''# '
#fi
#
PR_USERNAME="unknown"
PR_SYMBOL="unknown"
if [[ $USENAME == "root" ]] ; then
    PR_USERNAME=${PR_BD_RED}%n${PR_NOCOLOR}
    PR_SYMBOL=${PR_BD_RED}'#'${PR_NOCOLOR}
else
    PR_USERNAME=${PR_BD_GREEN}%n${PR_NOCOLOR}
    PR_SYMBOL=${PR_BD_GREEN}'$'${PR_NOCOLOR}
fi

PR_HOSTNAME="unknown"
if [ -n "$SSH_TTY" ]; then
    # highlight for ssh session.
    PR_HOSTNAME=${PR_BD_RED}%m${PR_NOCOLOR}
else
    PR_HOSTNAME=${PR_BD_GREEN}%m${PR_NOCOLOR}
fi

PR_TTY="unknown"
PR_TTY=${PR_YELLOW}%y${PR_NOCOLOR}

PR_PWD="unknown"
PR_PWD=${PR_BD_CYAN}%~${PR_NOCOLOR}

#{${vcs_info_msg_0_}} ${PR_SYMBOL} "
#PS1="${PR_USERNAME}@${PR_HOSTNAME}$ on ${PR_TTY} in ${PR_PWD}
#{${vcs_info_msg_0_}} %(!.%F{red}$(prompt_char)%f.$(prompt_char)) %{$reset_color%}"

# default prompt
#PS1='%(!.%B%U%F{blue}%n%f%u%b.%F{green}%n%f)@%F{green}%m%f on %F{yellow}%y%f in %F{cyan}%~%f
#{${vcs_info_msg_0_}} %(!.%F{red}$(prompt_char)%f.$(prompt_char)) %{$reset_color%}'

PS1='%(!.%B%U%F{blue}%n%f%u%b.%F{green}%n%f)@${PR_HOSTNAME} on ${PR_TTY} in ${PR_PWD}
{${vcs_info_msg_0_}} %(!.%F{red}$(prompt_char)%f.$(prompt_char)) %{$reset_color%}'

# default prompt's right side
# show date and time
# [format] hh:mm year-month-day weekday
#RPS1='%F{cyan}%D{%H:%M %Y-%m-%d %a}%f%{$reset_color%}'
RPS1='${PR_CYAN}%D{%H:%M %Y-%m-%d %a}${PR_NOCOLOR}'

# prompt for complex flow control, such as if, for and while.
# '%_' will be replace with the parser's current state by zsh
PS2='{%_} '

#prompt for 'select' statement
PS3='{ ... } '

# So far I don't use "setopt xtrace", so I don't need this prompt
# prompt for 'xtrace' option
PS4='{%_} '
