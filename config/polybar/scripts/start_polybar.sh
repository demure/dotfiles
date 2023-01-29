#!/bin/bash
## This is my (demuredemeanor) polybar script for starting polybar and dealing with multiple monitors.
## Doesn't address tray, as I don't use it.

## Kill old polybars
## NOTE: This started needing a -x recently??
pkill -x polybar

sleep 3

for m in $(xrandr --query | awk '/ connected/ {print $1}'); do
    MONITOR=$m polybar --reload &
done
