# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

export HISTSIZE= 
export HISTFILESIZE=
export HISTFILE="$XDG_STATE_HOME/bash/history"

# Avoid duplicate entries
export HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ll:ls:bg:fg:history:clear:lfcd:poweroff:reboot"

export GPG_TTY="$(tty)"

if [ -x /usr/bin/dircolors ]; then
  eval "$(dircolors -b $XDG_CONFIG_HOME/dircolors/colors)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias diff='colordiff'
  alias grep='grep -i --color=auto'
  alias fgrep='fgrep -i --color=auto'
  alias egrep='egrep -i --color=auto'
fi

alias doas='doas '
alias ll='ls -alhv --group-directories-first'
alias cgit="git --git-dir=$HOME/.config/dotfiles.git --work-tree=$HOME"
alias vim='nvim'
alias cal='cal -m'
alias ssh='TERM=xterm-256color ssh'
alias wget=wget --hsts-file="$XDG_DATA_HOME/wget-hsts"
alias wttr='curl wttr.in'

FG_GREY="\001\e[1;90m\002"
FG_GREEN="\001\e[1;32m\002"
FG_BLUE="\001\e[1;34m\002"
FG_PURPLE="\001\e[1;35m\002"
FG_CYAN="\001\e[1;36m\002"
FG_RED="\001\e[1;31m\002"
RESET="\001\e[0m\002"

PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

__prompt() {
  if [ $? = 0 ]; then
    local prompt_color="$FG_GREEN"
  else
    local prompt_color="$FG_RED"
  fi

  local cwd=$(printf ${PWD/#$HOME/\~} | sed -E 's:([.]?[^/])[^/]*/:\1/:g')

  printf "${FG_GREY}${cwd} ${prompt_color}%% "
}

PS1="\$(__prompt)${RESET}"

lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        if [ -d "$dir" ]; then
            if [ "$dir" != "$(pwd)" ]; then
                cd "$dir"
            fi
        fi
    fi
}

__fzf_checkout() {
  git for-each-ref refs/heads/ --format='%(refname:short)' | sort -n | fzf | xargs git checkout
}

bind '"\C-b":"__fzf_checkout\C-m"'
bind '"\C-o":"lfcd\C-m"'

eval "$(direnv hook bash)"

