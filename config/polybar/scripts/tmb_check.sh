#!/bin/sh
## This is my (demuredemeanor) polybar script for checking Thinkpad Multi Battery (TMB).
## This script handles both one and two batteries, and in the case of the latter provides a weighted percentage.

### Color Vars ### {{{
## polybar segment color
## Toggle Segment Color (1 or 2)
POLY_SEG=2

## Declare colors
M_BG_SEG1="#282A2E"
M_BG_SEG2="#454A4F"

M_FG="#C5C8C6"
M_FG_ICON="#979997"

## Alert Colors
COLOR_LOW="#DC322F"           ## Background for low bat threshold
COLOR_MID="#CB4B16"           ## Background for mid bat threshold
COLOR_HIGH="#B58900"          ## Icon for high bat threshold
COLOR_PLUG="#859900"          ## Forground for 70-100 battery icon

## Enact Toggle
if [ ${POLY_SEG} -eq 1 ]; then
    BG="${M_BG_SEG1}"
    OBG="${M_BG_SEG2}"
  else
    BG="${M_BG_SEG2}"
    OBG="${M_BG_SEG1}"
fi
### End Color Vars ### }}}

## Alert Levels
## Note: levels higher than 'high' will not be highlighted.
ALERT_LOW=10
ALERT_MID=15
ALERT_HIGH=25


### Batteries ### {{{
## Prep possible batteries
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
### End Batteries ### }}}

### Data ### {{{
## Aggregate data
if [ "${BAT0}" != "" ] || [ "${BAT1}" != "" ]; then
    ## Originally "/sys/class/power_supply/BAT{0..1}/uevent" but changed into variables make work for non thinkpad cases. paste fails if it can't find a passed file.
    BASE="$(paste -d = ${BAT0} ${BAT1} 2>/dev/null)"

    PERC="$(echo "${BASE}" | awk 'BEGIN {CHARGE="U"} /ENERGY_FULL=/||/ENERGY_NOW=/||/CHARGE_NOW=/||/CHARGE_FULL=/ {split($0,a,"=");  if(a[1]~/FULL/){FULL=a[2]+a[4]}; if(a[1]~/NOW/){NOW=a[2]+a[4]};} END {if(NOW!=""){PERC=int((NOW/FULL)*100)} else {PERC="none"}; print(PERC)}')"

    ## "F" for full, "C" for charging, "D" for discharging, "U" for unknown (Treat is charged")
    STATE="$(echo "${BASE}" | awk 'BEGIN {CHARGE="U"} /STATUS=/ {split($0,a,"="); if(a[2]~/Discharging/||a[4]~/Discharging/){CHARGE="D"} else if(a[2]~/Charging/||a[4]~/Charging/){CHARGE="C"} else if (a[2]~/Full/||a[4]~/Full/){CHARGE="F"};} END {print(CHARGE)}')"

    ## Time till fully charged or discharged, only of currently active battery
    TIME="$(acpi -b | awk '/[0-9]+:[0-9]+:[0-9]+ (until|remaining)/ {if($5!=""){split($5,s,":");if(s[1]!="00"){HOUR=s[1]"h"};if(s[2]!="00"){MIN=s[2]"m"};TIME=HOUR MIN}} END {if(TIME!=""){print TIME} else {print "none"}}')"
fi
### End Data ### }}}

### Icons ### {{{
## Prep Icons
if [ ${STATE} != "C" ]; then
    ## Battery Icons
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
  else
    ## Charging Icon, embedding color to cheat
    ICON="%{F${COLOR_PLUG}}"
fi

## Remaining Time Icon, embedding color to cheat
#T_ICON=""
#T_ICON=""
T_ICON=""
### End Icons ### }}}

### Time Formatting ### {{{
## Prep Remaining Time, if any
if [ ${TIME} != "none" ]; then
    FORM_TIME="%{F${M_FG_ICON}}%{O2}${T_ICON}%{O2}%{F${M_FG}}${TIME}"
else
    FORM_TIME=""
fi
### End Time Formatting ### }}}

### Output Formatting ### {{{
## Prep Level Color
if [ ${PERC} -le ${ALERT_LOW} ]; then
    ## Low (last) Alert
    STATUS="%{B${OBG} F${BG}}%{B${BG} F${COLOR_LOW}}%{B${COLOR_LOW} F${M_FG_ICON}}%{O2}${ICON}%{O2}%{F${M_FG}}${PERC}%%{O2}%{F${BG}}%{B${BG}}${FORM_TIME}%{O2}"
elif [ ${PERC} -le ${ALERT_MID} ]; then
    ## Med (second) Alert
    STATUS="%{B${OBG} F${BG}}%{B${BG} F${COLOR_MID}}%{B${COLOR_MID} F${M_FG_ICON}}%{O2}${ICON}%{O2}%{F${M_FG}}${PERC}%%{O2}%{F${BG}}%{B${BG}}${FORM_TIME}%{O2}"
elif [ ${PERC} -le ${ALERT_HIGH} ]; then
    ## High (first) Alert
    STATUS="%{B${OBG} F${BG}}%{B${BG} F${COLOR_HIGH}}%{O2}${ICON}%{O2}%{F${COLOR_HIGH}}${PERC}%%{O2}${FORM_TIME}%{O2}"
else
    ## Normal Output
    STATUS="%{B${OBG} F${BG}}%{B${BG} F${M_FG_ICON}}%{O2}${ICON}%{O2}%{F${M_FG}}${PERC}%%{O2}${FORM_TIME}%{O2}"
fi
### End Output Formatting ### }}}

## Output final results
echo "${STATUS}"
