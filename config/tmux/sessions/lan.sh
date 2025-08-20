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
    WINDOW='pi'
    NUM=1
    #tmux new-window -t ${SESSION}:1 -n 'pi'
    tmux rename-window -t ${SESSION}:${NUM} ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='ex'
    NUM=2
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='pr'
    NUM=3
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='so'
    NUM=4
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='ta'
    NUM=5
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='sh'
    NUM=6
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='lc'
    NUM=7
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='ld'
    NUM=8
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='le'
    NUM=9
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m

    WINDOW='su'
    NUM=10
    tmux new-window -t ${SESSION}:${NUM} -n ${WINDOW}
    tmux send-keys -t ${WINDOW} "ssh -t ${WINDOW} 'tmux attach -t 0 || tmux new'" C-m
fi


## Attach after session generated
tmux attach-session -t ${SESSION}
