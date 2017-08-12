#!/usr/bin/zsh
# toggle between maximized and centered

PADDING=3

active_win=$(xdotool getactivewindow)
screen_dimensions=$(xdpyinfo | pcregrep -o1 -o2 --om-separator=' ' 'dimensions:\s*(\d+)x(\d+)')
screen_width=$(echo $screen_dimensions | cut -d' ' -f1)
screen_height=$(echo $screen_dimensions | cut -d' ' -f2)

i3bar_win=$(xdotool search --class i3bar)
i3bar_info=$(xwininfo -id `echo $i3bar_win`)
i3bar_info=$(echo $i3bar_info | pcregrep -o1 -o2 -e '^\s*(Height:|Width:|Absolute upper-left Y:)\s*(.*)' | sort | sed 's/[^0-9]*//g' | tr '\n' ' ')

i3bar_offset_top=$(echo $i3bar_info | cut -d' ' -f1)
i3bar_height=$(echo $i3bar_info | cut -d' ' -f2)
i3bar_width=$(echo $i3bar_info | cut -d' ' -f3)

position_x=$PADDING

if [[ $i3bar_offset_top -eq 0 ]]; 
	then
		position_y=$(echo "$PADDING + $i3bar_height" | bc)
	else
		position_y=$PADDING
fi

window_width=$(echo "$screen_width - (2 * $PADDING)" | bc)
window_height=$(echo "$screen_height - (2 * $PADDING) - $i3bar_height" | bc)

xdotool windowmove $active_win $position_x $position_y
xdotool windowsize $active_win $window_width $window_height
