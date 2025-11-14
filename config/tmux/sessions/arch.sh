#!/bin/bash

## A script to start up custom profile of a tmux session
##
## NOTE: This assumes that "set -g base-index 1" is set.


SESSION="arch"


## Create a new detached tmux session if it doesn't exist
tmux has-session -t ${SESSION} 2>/dev/null


if [ $? != 0 ]; then
    ## Create Session
    tmux new-session -d -s ${SESSION} -c ${HOME}

    ## Create windows
    WINDOW='maint'
    NUM=1
    tmux rename-window -t ${SESSION}:${NUM} ${WINDOW}
    tmux send-keys -t ${WINDOW} "sudo -s" C-m
    tmux split-window -t ${SESSION}:${NUM} -h

    WINDOW='mail'
    NUM=2
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "neomutt" C-m

    WINDOW='file'
    NUM=3
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ranger" C-m
fi


## Attach after session generated
tmux attach-session -t ${SESSION}
