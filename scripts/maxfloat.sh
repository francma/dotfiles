#!/bin/sh
set -eu

PADDING=2

active_win=$(xdotool getactivewindow)
screen_dimensions=$(xdpyinfo | grep 'dimensions' | xargs | cut -d' ' -f2)

screen_width=$(echo $screen_dimensions | cut -d'x' -f1)
screen_height=$(echo $screen_dimensions | cut -d'x' -f2)

i3bar_win=$(xdotool search --class i3bar)
i3bar_info=$(xwininfo -id `echo $i3bar_win`)

i3bar_offset_top=$(echo "$i3bar_info" | grep 'Absolute upper-left Y:' | rev | cut -d' ' -f1 | rev)
i3bar_height=$(echo "$i3bar_info" | grep 'Height:' | rev | cut -d' ' -f1 | rev)
i3bar_width=$(echo "$i3bar_info" | grep 'Width:' | rev | cut -d' ' -f1 | rev)

position_x=$PADDING

if [[ $i3bar_offset_top -eq 0 ]]; then
	position_y=$(echo "$PADDING + $i3bar_height" | bc)
else
	position_y=$PADDING
fi

window_width=$(echo "$screen_width - (2 * $PADDING)" | bc)
window_height=$(echo "$screen_height - (2 * $PADDING) - $i3bar_height" | bc)

xdotool windowmove $active_win $position_x $position_y
xdotool windowsize $active_win $window_width $window_height
