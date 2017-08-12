#!/bin/zsh

i3bar_win=$(xdotool search --class i3bar)
i3bar_info=$(xwininfo -id `echo $i3bar_win`)
i3bar_info=$(echo $i3bar_info | pcregrep -o1 -o2 -e '^\s*(Height:|Width:|Absolute upper-left Y:)\s*(.*)' | sort | sed 's/[^0-9]*//g' | tr '\n' ' ')

i3bar_offset_top=$(echo $i3bar_info | cut -d' ' -f1)
i3bar_height=$(echo $i3bar_info | cut -d' ' -f2)
i3bar_width=$(echo $i3bar_info | cut -d' ' -f3)

icon_number=$1
click_pos_h=$(echo "$i3bar_offset_top + ($i3bar_height / 2)" | bc)
click_pos_w=$(echo "$i3bar_width - (($icon_number - 1) * $i3bar_height) - ($i3bar_height / 2)" | bc)

xdotool mousemove $click_pos_w $click_pos_h click 1 mousemove restore