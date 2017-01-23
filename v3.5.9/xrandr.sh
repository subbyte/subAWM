#!/usr/bin/env bash

EXTMONITOR=$(xrandr -q | grep " connected" | awk '{print $1}' | grep -v LVDS1)

if [ -n "$EXTMONITOR" ]; then
    xrandr --output LVDS1 --auto --output $EXTMONITOR --auto --right-of LVDS1
else
    xrandr --output LVDS1 --auto --output DP1 --auto --output DP2 --auto --output HDMI1 --auto --output HDMI2 --auto --output VGA1 --auto
fi
