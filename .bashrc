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

export EDITOR="vim"

case "$TERM" in
    xterm*|rxvt*)
        TERM=xterm-256color
        ;;
esac
if [[ $TERM == xterm-termite ]]; then
  . /etc/profile.d/vte.sh
  __vte_osc7
fi
[ -z "$TMUX" ] && export TERM=xterm-256color

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
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

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUPSTREAM="auto verbose"
export GIT_PS1_SHOWCOLORHINTS=true

PS1="\$([[ \$? != 0 ]] && echo \"\[\033[1;37m\][\[\033[1;31m\]💥 \[\033[1;37m\]]\")\[\033[1;31m\]\t \[\033[1;32m\]\u\[\033[1;36m\]:\[\033[1;35m\]\w \[\033[1;36m\]\$(/bin/ls -1 | /usr/bin/wc -l | /usr/bin/sed \"s: ::g\") \[\033[1;33m\]\$(__git_ps1 \"(%s)\")\n\[\033[1;33m\]>>>\[\033[0m\]"

# Change the window title of X terminals
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

alias m='neomutt'

#mkdir,cd into it
mkcd(){
	mkdir -p "$*"
	cd "$*"
}

#mail
export MAILCHECK=60
export MAILPATH=~/.mail/gmail/inbox?"Gmail has mail!":~/.mail/work/inbox?"Work has mail!"

#stty stop ^J
stty stop undef

#gruvbox
# https://github.com/morhetz/gruvbox/wiki/Terminal-specific
#source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

#notes
#http://www.eddieantonio.ca/blog/2015/04/16/iterm-italics/

if [ "$TERM"="linux" ] ;then
  export LANG="en_US.UTF-8"
fi

#fzf
[ -f /usr/share/fzf/completion.bash ] && source /usr/share/fzf/completion.bash
[ -f /usr/share/fzf/key-bindings.bash ] && source /usr/share/fzf/key-bindings.bash
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'

#rupa/z.sh
source $HOME/.mybashscripts/z.sh
alias zz='z -c'

#dict
dict () {
    curl dict://dict.org/d:"${1}"
}

complete -cf sudo
