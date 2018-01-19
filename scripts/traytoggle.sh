#!/bin/sh
set -eu

i3bar_win=$(xdotool search --class i3bar)
i3bar_info=$(xwininfo -id $i3bar_win)

i3bar_offset_top=$(echo "$i3bar_info" | grep 'Absolute upper-left Y:' | rev | cut -d' ' -f1 | rev)
i3bar_height=$(echo "$i3bar_info" | grep 'Height:' | rev | cut -d' ' -f1 | rev)
i3bar_width=$(echo "$i3bar_info" | grep 'Width:' | rev | cut -d' ' -f1 | rev)

icon_number=$1
click_pos_h=$(echo "$i3bar_offset_top + ($i3bar_height / 2)" | bc)
click_pos_w=$(echo "$i3bar_width - (($icon_number - 1) * $i3bar_height) - ($i3bar_height / 2)" | bc)

xdotool mousemove $click_pos_w $click_pos_h click 1 mousemove restore