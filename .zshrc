# disable last command re-play
disable r

# keybinds
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line
bindkey "${terminfo[kdch1]}" delete-char
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word

if [[ $TERM == xterm-termite ]] then
  bindkey "^[[H" beginning-of-line
  bindkey "^[[F" end-of-line
fi

# beep off
xset -b

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
alias ll='ls -alh'
alias subl='subl3'
alias make='make -j4'
alias noise='head -10 /dev/urandom | padsp tee | aplay 2>/dev/null 1>/dev/null'
alias cgit='/usr/bin/git --git-dir=/home/anon/.cfg/ --work-tree=/home/anon'
alias vim='nvim'
alias attendance='packeta-attendance martin.franc@zasilkovna.cz $(gpg --decrypt < ~/.password-store/zasilkovna/admin/martin.franc@zasilkovna.cz.gpg 2>/dev/null | head -1)'

# history
HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000
bindkey '^R' history-incremental-search-backward
setopt incappendhistory sharehistory

# autocomplete
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
autoload -U compinit promptinit
compinit
promptinit

autoload -U colors && colors

# prompt
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
precmd() {
    vcs_info
}
zstyle ':vcs_info:git*' formats " %{$fg_bold[green]%}[%{$fg_bold[blue]%}%s: %b%{$fg_bold[green]%}]"
setopt prompt_subst

PROMPT='%{$bg[black]%}%{$fg_bold[red]%}%(?..[%?] )%{%(#~$fg[red]~$fg[green])%}[%{$fg_bold[blue]%}%~%{%(#~$fg[red]~$fg[green])%}]${vcs_info_msg_0_}%E
%{$reset_color%}%{$fg_bold[blue]%}λ%{$reset_color%} '

# ranger
ranger-cd() {
  tempfile=$(mktemp)
  ranger --choosedir="$tempfile" "${@:-$(pwd)}" < $TTY
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
    cd -- "$(cat "$tempfile")"
  fi
  rm -f -- "$tempfile"
}

zle -N ranger-cd
bindkey '^o' ranger-cd

# python virtualenv completions
source $(which virtualenvwrapper_lazy.sh)

