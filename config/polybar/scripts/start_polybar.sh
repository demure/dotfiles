#bin/bash
## This is my (demuredemeanor) polybar script for starting polybar and dealing with multiple monitors.
## Doesn't address tray, as I don't use it.

## Kill old polybars
pkill polybar

sleep 5

for m in $(xrandr --query | awk '/ connected/ {print $1}'); do
    MONITOR=$m polybar --reload main &
done
