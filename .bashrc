# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# Set scale factor for X11
WINIT_X11_SCALE_FACTOR=1

# If not running interactively, don't do anything
case $- in          # iterate through shell flags
    *i*) ;;         # if interactive, do nothing
      *) return;;   # if anything else, return
esac


# starship
eval "$(starship init bash)"

# helper functions
cheat() { curl cheat.sh/$1; }
weather() { curl wttr.in; }
weather2() { curl v2.wttr.in; }
alias prettyjson="python3 -m json.tool"

# goto to fuzzy dir
kek() {
    if [ -z $1 ]; then
        SOURCE_DIR=$HOME
    else
        SOURCE_DIR=$1
    fi
    TEMP_DIR=$(find "$SOURCE_DIR" -type d | fzf)
    if [ "$TEMP_DIR" != "" ]; then
        cd $TEMP_DIR
    fi
}

# edit fuzzy file
alias vk='TEMP_DIR=$(find "." -type f | fzf); [ "$TEMP_DIR" = "" ] || nvim $TEMP_DIR'



# See bash(1) for more options
HISTCONTROL=ignoreboth  # ignore duplicate lines and those starting with ' '
shopt -s histappend     # append to the history file, don't overwrite it
HISTSIZE=1000           # history command size
HISTFILESIZE=2000       # history file size


# check the window size after each command and update LINES and COLUMNS
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar


# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "${chroot_env:-}" ]; then
#     if [ -r /etc/debian_chroot ]; then
#         chroot_env=$(cat /etc/debian_chroot)
#     elif [ -r /etc/arch-release ]; then
#         chroot_env="arch_chroot"
#     fi
# fi

# colorful prompt
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# force_color_prompt can be uncommented to always enable color prompts
# force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${chroot_env:+($chroot_env)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${chroot_env:+($chroot_env)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

#
# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${chroot_env:+($chroot_env)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac


# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Source files from local directory
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# Load Cargo environment if it exists
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
