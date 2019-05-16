#!/usr/bin/env bash

ON=eDP1
OFF=HDMI1

if [ -n "$(xrandr --listactivemonitors | grep eDP1)" ]
then
  # laptop screen is enabled, toggle
  ON=HDMI1
  OFF=eDP1
fi

DISPLAY=":0.0" xrandr --output ${ON} --auto --output ${OFF} --off --output DP1 --off --output DP2 --off --output VIRTUAL1 --off
