# Update window size after every command
shopt -s checkwinsize

# Enable history expansion with space
# E.g. typing !!<space> will replace the !! with your last command
bind Space:magic-space

# Turn on recursive globbing (enables ** to recurse all directories)
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Perform file completion in a case insensitive fashion
bind "set completion-ignore-case on"

# Treat hyphens and underscores as equivalent
bind "set completion-map-case on"

# Display matches for ambiguous patterns at first tab press
bind "set show-all-if-ambiguous on"

# Immediately add a trailing slash when autocompleting symlinks to directories
bind "set mark-symlinked-directories on"

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

HISTSIZE=1000  
HISTFILESIZE=2000

# Avoid duplicate entries
HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ll:ls:bg:fg:history:clear:lfcd:viso:web4u"

# Enable incremental history search with up/down arrows (also Readline goodness)
# Learn more about this here: http://codeinthehole.com/writing/the-most-important-command-line-tip-incremental-history-searching-with-inputrc/
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\e[C": forward-char'
bind '"\e[D": backward-char'


if [ -x /usr/bin/dircolors ]; then
  eval "$(dircolors -b ~/.dircolors)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias diff='colordiff'
  alias grep='grep -i --color=auto'
  alias fgrep='fgrep -i --color=auto'
  alias egrep='egrep -i --color=auto'
fi

alias sudo='sudo -E '
alias ll='ls -alh --group-directories-first'
alias cgit='/usr/bin/git --git-dir=/home/anon/.cfg/ --work-tree=/home/anon'
alias vim='nvim'
alias attendance="web4u-attendance francm $WEB4U_ADM_PASSWORD"
alias web4u='cd ~/web4u/docker-env/data100/web4u'
alias viso='cd ~/viso/docker-env/projects/kukacka'
alias cal='cal -m'
alias composer='composer --ignore-platform-reqs'

readonly FG_GREY="\e[1;90m"
readonly FG_GREEN="\e[1;32m"
readonly FG_BLUE="\e[1;34m"
readonly FG_RED="\e[1;31m"
readonly RESET="\e[0m"

last_command() {
  local retcode="$?"
  [[ $retcode != 0 ]] && printf " \001${FG_RED}\002[${retcode}]"
}

git_branch() {
  local branch="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
  [[ "${branch}" != "" ]] && printf "\001${FG_GREEN}\002[\001${FG_BLUE}\002git: ${branch}\001${FG_GREEN}\002]"
}

export PS1="\[${FG_GREY}\][\A]\$(last_command) \[${FG_GREEN}\][\[${FG_BLUE}\]\w\[${FG_GREEN}\]] \$(git_branch)\n\[${FG_BLUE}\]> \[${RESET}\]"

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

bind '"\C-o":"lfcd\C-m"'