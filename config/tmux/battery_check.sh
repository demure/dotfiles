#!/bin/bash

## A script to grab battery state for my (demuredemeanor) tmux statusbar


## Termux battery
if [ $OSTYPE == "linux-android" ]; then
    if [ $(command -v termux-battery-status) ]; then
        PERC=$(termux-battery-status | awk '/percentage/ {sub(/,/,""); print $2}')
    fi
fi

case ${PERC} in
    100|9[5-9])     ICON="" ;;     ## Full Icon 95-100%
    8[5-9]|9[0-4])  ICON="" ;;     ## 90% Icon 85-94%
    7[5-9]|8[0-4])  ICON="" ;;     ## 80% Icon 75-84%
    6[5-9]|7[0-4])  ICON="" ;;     ## 70% Icon 65-74%
    5[5-9]|6[0-4])  ICON="" ;;     ## 60% Icon 55-64%
    4[5-9]|5[0-4])  ICON="" ;;     ## 50% Icon 45-54%
    3[5-9]|4[0-4])  ICON="" ;;     ## 40% Icon 35-44%
    2[5-9]|3[0-4])  ICON="" ;;     ## 30% Icon 25-34%
    1[5-9]|2[0-4])  ICON="" ;;     ## 20% Icon 15-24%
    [5-9]|1[0-4])   ICON="" ;;     ## 10% Icon 5-14%
    [0-4])          ICON="" ;;     ## Empty Icon 0-4%
    *)              ICON="" ;;     ## Catchall Question Icon
esac

echo -e "${ICON} ${PERC}%\n"
