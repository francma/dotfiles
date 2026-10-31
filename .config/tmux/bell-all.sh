#!/bin/sh
# $1 = session that rang; its own clients already got BEL via bell-action
tmux list-clients -F '#{client_tty} #{client_session}' |
while read -r tty sess; do [ "$sess" = "$1" ] || printf '\a' > "$tty"; done
