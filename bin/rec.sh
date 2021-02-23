#!/bin/sh
mkdir -p ~/rec
cd ~/rec

pactl set-card-profile 0 'output:analog-stereo+input:analog-stereo'

while true; do
  prefix=`hostname`.`date +%Y%m%dT%H%M%SZ`
  output="$prefix".mp3
  output2="$prefix".silence.mp3

  date
  arecord -f cd -t raw -d 3600 | lame -r - "$output" || break
  ffmpeg -i "$output" -filter_complex 'silenceremove=stop_periods=-1:stop_duration=4:stop_threshold=-12dB' "$output2" &
done

#pactl set-card-profile 0 'output:hdmi-stereo'
