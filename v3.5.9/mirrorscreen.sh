#!/usr/bin/env bash

EXTMONITOR=$(xrandr -q | grep " connected" | awk '{print $1}' | grep -v eDP1)

if [ -n "$EXTMONITOR" ]; then
    xrandr --output eDP1 --mode 1920x1080 --output $EXTMONITOR --mode 1920x1080 --same-as eDP1
else
    xrandr --output eDP1 --auto --output DP1 --auto --output DP2 --auto --output HDMI1 --auto --output HDMI2 --auto
fi
