#!/bin/sh
## This is my (demuredemeanor) polybar script for handling playerctl.
## mpv support needs mpv-mpris


## Initialize variable
PLAYER_CHECK="none"


## Verify program exists
if [ "${PLAYER_CHECK}" = "none" ] && [ $(command -v playerctl) ]; then
    #PLAYER_CHECK="$(playerctl --player=%any,chromium metadata --format '{{ artist }} - {{ title }}' 2>/dev/null)"
    PLAYER_CHECK="$(playerctl --player=%any,chromium metadata --format '{{ artist }} - {{ title }} {{ status }}' 2>/dev/null | awk '{STATE=$NF; $NF=""; if(STATE!="Stopped"){if(STATE=="Paused"){print STATE " - " $0}else{print $0}}}' )"
fi

## If no music, return fancy none icon
if [ "${PLAYER_CHECK}" = "" ]; then
    PLAYER_CHECK="×"
fi

echo $PLAYER_CHECK
