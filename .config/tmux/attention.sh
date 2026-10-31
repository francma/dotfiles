#!/bin/sh
# $1 = client name, $2 = pane id; tree filter falls back to "all" on no match, hence the check
if tmux list-windows -a -f '#{window_bell_flag}' | grep -q .; then
  tmux choose-tree -t "$2" -Zw -f '#{window_bell_flag}'
else
  tmux display -c "$1" 'nothing waiting'
fi
