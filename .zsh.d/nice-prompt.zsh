# http://matija.suklje.name/?q=node/207

# Enables additional prompt extentions
setopt prompt_subst

# Enables colours
autoload -U colors && colors

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


# default prompt
PS1='%(!.%B%U%F{blue}%n%f%u%b.%F{green}%n%f)@%F{green}%m%f on %F{yellow}%y%f in %F{cyan}%~%f
{${vcs_info_msg_0_} %(!.%F{red}$(prompt_char)%f.$(prompt_char)) }: %{$reset_color%}'

# default prompt's right side
# show date and time
# [format] hh:mm year-month-day weekday
RPS1='%F{cyan}%D{%H:%M %Y-%m-%d %a}%f%{$reset_color%}'

# prompt for complex flow control, such as if, for and while.
# '%_' will be replace with the parser's current state by zsh
PS2='{%_} '

#prompt for 'select' statement
PS3='{ ... } '

# So far I don't use "setopt xtrace", so I don't need this prompt
# prompt for 'xtrace' option
PS4='{%_} '
