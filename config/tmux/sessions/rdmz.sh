#!/bin/bash

## A script to start up a nested tmux controlling session
##
## NOTE: This assumes that "set -g base-index 1" is set.


SESSION="control"


## Create a new detached tmux session if it doesn't exist
tmux has-session -t ${SESSION} 2>/dev/null


if [ $? != 0 ]; then
    ## Create Session
    tmux new-session -d -s ${SESSION} -c ${HOME}

    ## Create windows
    WINDOW='r4'
    NUM=1
    #tmux new-window -t ${SESSION}:1 -n 'r4'
    tmux rename-window -t ${SESSION}:${NUM} ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='r8'
    NUM=2
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='ev'
    NUM=3
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='tr'
    NUM=4
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='mu'
    NUM=5
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='nu'
    NUM=6
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='xi'
    NUM=7
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='omicron'
    NUM=8
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m
    tmux rename-window -t ${SESSION}:${NUM} "om"

    WINDOW='pi'
    NUM=9
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='mat'
    NUM=10
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='beta'
    NUM=11
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m
    tmux rename-window -t ${SESSION}:${NUM} "be"

    WINDOW='car'
    NUM=12
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='con'
    NUM=13
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m
fi


## Attach after session generated
tmux attach-session -t ${SESSION}
