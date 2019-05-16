#!/usr/bin/env bash

case $1 in
  up)
    pactl set-sink-volume 0 +5%
    ;;
  down)
    pactl set-sink-volume 0 -5%
    ;;
  mute)
    pactl set-sink-mute 0 toggle
    ;;
esac

pkill -RTMIN+1 i3blocks
