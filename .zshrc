# disable last command re-play
disable r

noop () {}
zle -N noop

# keybinds
bindkey "${terminfo[kdch1]}" delete-char
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[knp]}" noop
bindkey "${terminfo[kpp]}" noop
bindkey "${terminfo[kich1]}" noop

# aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'
  alias diff='colordiff'
  alias grep='grep -i --color=auto'
  alias fgrep='fgrep -i --color=auto'
  alias egrep='egrep -i --color=auto'
fi

alias sudo='sudo -E '
alias setclip='xclip -selection c'
alias getclip='xclip -selection clipboard -o'
alias ll='ls -alh --group-directories-first'
alias make='make -j4'
alias noise='head -10 /dev/urandom | padsp tee | aplay 2>/dev/null 1>/dev/null'
alias cgit='/usr/bin/git --git-dir=/home/anon/.cfg/ --work-tree=/home/anon'
alias vim='nvim'
alias attendance="web4u-attendance francm $WEB4U_ADM_PASSWORD"
alias web4u='cd ~/web4u/docker-env/data100/web4u'
alias viso='cd ~/viso/docker-env/projects/kukacka'

# history
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
bindkey '^r' history-incremental-search-backward
setopt incappendhistory sharehistory

# autocomplete
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -U compinit promptinit
compinit
promptinit

autoload -U colors && colors

# prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
precmd() {
    vcs_info
}
zstyle ':vcs_info:git*' formats " %F{green}[%F{blue}%s: %b%F{green}]"
setopt prompt_subst

PROMPT='%B%K{black}%F{black}[%D{%H:%M}] %F{red}%(?..[%?] )%F{green}[%F{blue}%~%F{green}]${vcs_info_msg_0_}%E
%k%F{blue}>%k%f%b%u '

# ranger
function ranger-cd {
    tempfile="$(mktemp -t tmp.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$(pwd)}"
    test -f "$tempfile" &&
    if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
        cd -- "$(cat "$tempfile")"
    fi
    rm -f -- "$tempfile"
}

bindkey -s '^o' 'ranger-cd^M'

# python virtualenv completions
source $(which virtualenvwrapper_lazy.sh)

# added by travis gem
[ -f /home/anon/.travis/travis.sh ] && source /home/anon/.travis/travis.sh

# autostart i3wm
if [ $(tty) = "/dev/tty1" ]; then
    startx
    exit 0
fi
