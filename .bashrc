# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
# better history with multi session
shopt -s histappend
PROMPT_COMMAND='history -a'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=2000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

shopt -s extglob

#stty stop ^J
stty stop undef

export EDITOR="vim"
export LC_ALL="en_US.UTF-8"

# color for man pages
export LESS_TERMCAP_mb=$'\E[01;31m' # begin blinking
export LESS_TERMCAP_md=$'\E[01;31m' # begin bold
export LESS_TERMCAP_me=$'\E[0m' # end mode
export LESS_TERMCAP_se=$'\E[0m' # end standout-mode
export LESS_TERMCAP_so=$'\E[01;44m' # begin standout-mode – info
export LESS_TERMCAP_ue=$'\E[0m' # end underline
export LESS_TERMCAP_us=$'\E[32m' # begin underline
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)
export LESS_TERMCAP_ZN=$(tput ssubm)
export LESS_TERMCAP_ZV=$(tput rsubm)
export LESS_TERMCAP_ZO=$(tput ssupm)
export LESS_TERMCAP_ZW=$(tput rsupm)

if [[ "$OSTYPE" == "linux"* ]]; then
    source /usr/share/git/completion/git-prompt.sh
    export GIT_PS1_SHOWDIRTYSTATE=true
    export GIT_PS1_SHOWUNTRACKEDFILES=true
    export GIT_PS1_SHOWSTASHSTATE=true
    export GIT_PS1_SHOWUPSTREAM="auto verbose"
    export GIT_PS1_SHOWCOLORHINTS=true
    export GIT_PS1_SHOWCONFLICTSTATE=true
    PS1="\$([[ \$? != 0 ]] && echo \"\[\033[1;37m\][\[\033[1;31m\]💥\[\033[1;37m\]]\")\[\033[1;31m\]\t \[\033[1;32m\]\u\[\033[1;36m\]:\[\033[1;35m\]\w \[\033[1;36m\]\$(/bin/ls -1 | /usr/bin/wc -l | /usr/bin/sed \"s: ::g\") \[\033[1;33m\]\$(__git_ps1 \"(%s)\")\n\[\033[1;33m\]>>>\[\033[0m\]"
elif [[ "$OSTYPE" == "darwin"* ]]; then

    # homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"
    # bash completion
    if [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]]; then
        export BASH_COMPLETION_COMPAT_DIR="/opt/homebrew/etc/bash_completion.d"
        . "/opt/homebrew/etc/profile.d/bash_completion.sh"
    fi

    # cli color
    export CLICOLOR=1
    export LSCOLORS=ExFxCxDxBxegedabagacad
    PS1="\$([[ \$? != 0 ]] && echo \"💥 \")\[\033[1;91m\]\t \[\033[1;92m\]\u\[\033[1;96m\]:\[\033[1;95m\]\w \[\033[1;96m\]\$(/bin/ls -1 | /usr/bin/wc -l | /usr/bin/sed \"s: ::g\")\[\033[1;93m\]\$(git-radar --bash --fetch)\n\[\033[1;93m\]>>>\[\033[0m\]"
fi

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

#mail
export MAILCHECK=60
export MAILPATH=~/.mail/gmail/inbox?"Gmail has mail!":~/.mail/work/inbox?"Work has mail!"

# enable color support of ls and also add handy aliases
# in fact, this is not working for bsd ls, only for gnu ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
fi

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# grep with color
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias m='neomutt'

# gruvbox
# https://github.com/morhetz/gruvbox/wiki/Terminal-specific
# source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

#notes
#http://www.eddieantonio.ca/blog/2015/04/16/iterm-italics/

#### handy functions ####

# mkdir,cd into it
mkcd(){
	mkdir -p "$*"
	cd "$*"
}

# dict
dict () {
    curl dict://dict.org/d:"${1}"
}


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION
export TERM=xterm-256color
