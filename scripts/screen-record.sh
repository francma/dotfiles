#!/bin/sh
set -eu

if [ -f '/tmp/ffmpeg_capture_pid' ]; then
	kill -2 $(cat /tmp/ffmpeg_capture_pid)
	rm /tmp/ffmpeg_capture_pid
	notify-send 'Video taken!'
	exit 0
fi

d=$(date +%Y-%m-%d_%H:%M:%S)
res=$(xrandr --current | grep '*' | uniq | awk '{print $1}')
ffmpeg -f x11grab -r 24 -s $res -i :0.0 -an -c:v libx264 -crf 0 -preset medium ~/Videos/videocaptures/vc_$d.mkv 1>/dev/null 2>/dev/null &
pid=$!
echo $pid > /tmp/ffmpeg_capture_pid
