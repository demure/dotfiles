#!/bin/bash

## A script to grab battery state for my (demuredemeanor) tmux statusbar


### Thinkpad Multi Battery (TMB) ### {{{
if [ -e /sys/class/power_supply/BAT0/uevent ]; then
    BAT0="/sys/class/power_supply/BAT0/uevent"
  else
    BAT0=""
fi

## Check for BAT1
if [ -e /sys/class/power_supply/BAT1/uevent ]; then
    BAT1="/sys/class/power_supply/BAT1/uevent"
  else
    BAT1=""
fi

## Aggregate data
if [ "${BAT0}" != "" ] || [ "${BAT1}" != "" ]; then
    ## Originally "/sys/class/power_supply/BAT{0..1}/uevent" but changed into variables make work for non thinkpad cases. paste fails if it can't find a passed file.
    BASE="$(paste -d = ${BAT0} ${BAT1} 2>/dev/null)"

    PERC="$(echo "${BASE}" | awk 'BEGIN {CHARGE="U"} /ENERGY_FULL=/||/ENERGY_NOW=/||/CHARGE_NOW=/||/CHARGE_FULL=/ {split($0,a,"=");  if(a[1]~/FULL/){FULL=a[2]+a[4]}; if(a[1]~/NOW/){NOW=a[2]+a[4]};} END {if(NOW!=""){PERC=int((NOW/FULL)*100)} else {PERC="none"}; print(PERC)}')"

fi
### End Thinkpad Multi Battery (TMB) ### }}}


### Termux battery ### {{{
if [ $OSTYPE == "linux-android" ]; then
    if [ $(command -v termux-battery-status) ]; then
        PERC=$(termux-battery-status | awk '/percentage/ {sub(/,/,""); print $2}')
    fi
fi
### End Termux battery ### }}}


## GPD Pocket 4
if [ -e /sys/class/power_supply/BATT/uevent ]; then
    PERC="$(cat /sys/class/power_supply/BATT/capacity)"
fi


## Prep Output
## NOTE: Using pragmata pro font chars
if [ ! -z "${PERC}" ]; then
    case ${PERC} in
        100|9[5-9])     ICON="󰁹" ;;     ## Full Icon 95-100%
        8[5-9]|9[0-4])  ICON="󰂂" ;;     ## 90% Icon 85-94%
        7[5-9]|8[0-4])  ICON="󰂁" ;;     ## 80% Icon 75-84%
        6[5-9]|7[0-4])  ICON="󰂀" ;;     ## 70% Icon 65-74%
        5[5-9]|6[0-4])  ICON="󰁿" ;;     ## 60% Icon 55-64%
        4[5-9]|5[0-4])  ICON="󰁾" ;;     ## 50% Icon 45-54%
        3[5-9]|4[0-4])  ICON="󰁽" ;;     ## 40% Icon 35-44%
        2[5-9]|3[0-4])  ICON="󰁼" ;;     ## 30% Icon 25-34%
        1[5-9]|2[0-4])  ICON="󰁻" ;;     ## 20% Icon 15-24%
        [5-9]|1[0-4])   ICON="󰁺" ;;     ## 10% Icon 5-14%
        [0-4])          ICON="󰂎" ;;     ## Empty Icon 0-4%
        *)              ICON="󰂑" ;;     ## Catchall Question Icon
    esac

    #echo -e "${ICON} ${PERC}%\n"
    echo "${ICON} ${PERC}%"
else
    echo -e "\n"
fi
