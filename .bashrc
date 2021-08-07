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

# bind -m vi-command 'Control-l: clear-screen'
# bind -m vi-insert 'Control-l: clear-screen'
# bind "set keyseq-timeout 10"

export HISTSIZE= 
export HISTFILESIZE=

# Avoid duplicate entries
export HISTCONTROL="erasedups:ignoreboth"

# Don't record some commands
export HISTIGNORE="&:[ ]*:exit:ll:ls:bg:fg:history:clear:lfcd:viso:web4u:poweroff:reboot"

export GPG_TTY="$(tty)"

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

upload_terminfo() {
	infocmp | ssh $@ tic -x -o \~/.terminfo /dev/stdin
}

alias doas='doas '
alias ll='ls -alh --group-directories-first'
alias cgit="git --git-dir=$HOME/.config/dotfiles.git --work-tree=$HOME"
alias vim='nvim'
alias attendance="web4u-attendance francm $WEB4U_ADM_PASSWORD"
alias cal='cal -m'
alias make='make -j$(nproc)'
alias view='vim -R'
alias ssh='TERM=xterm-256color ssh'
alias wiki='nvim -c ":VimwikiIndex"'

FG_GREY="\e[1;90m"
FG_GREEN="\e[1;32m"
FG_BLUE="\e[1;34m"
FG_PURPLE="\e[1;35m"
FG_CYAN="\e[1;36m"
FG_RED="\e[1;31m"
RESET="\e[0m"

last_command() {
  local retcode="$?"
  [ $retcode != 0 ] && printf "\001${FG_RED}\002[${retcode}] "
}

git_branch() {
  local branch="$(git branch --show-current 2>/dev/null)"
  [ "${branch}" != "" ] && printf "\001${FG_GREEN}\002[\001${FG_BLUE}\002git: ${branch}\001${FG_GREEN}\002]"
}

bind "set show-mode-in-prompt on"
bind "set vi-ins-mode-string \001${FG_BLUE}\002>\001${RESET}\002"
bind "set vi-cmd-mode-string \001${FG_BLUE}\002:\001${RESET}\002"

PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

PS1="\$(last_command)"
PS1="${PS1}\[${FG_GREEN}\][\[${FG_BLUE}\]\u\[${FG_CYAN}\]@\h\[${FG_GREEN}\]]"
PS1="${PS1}\[${FG_GREEN}\][\[${FG_BLUE}\]\w\[${FG_GREEN}\]]"
PS1="${PS1} \$(git_branch)\n"
PS1="${PS1} \[${RESET}\]"

if [ -f /usr/share/nnn/quitcd/quitcd.bash_zsh ]; then
  source /usr/share/nnn/quitcd/quitcd.bash_zsh
fi

bind '"\C-o":"n -d\C-m"'
bind '"\C-b":"git checkout $(git branch | fzf)\C-m"'
