#!/bin/sh
## This is my (demuredemeanor) polybar script for checking time and date, and handling UTC.

## This script allows me to toggle between my TZ and UTC.
## It is written to allow an i3 binding to toggle too.
## The following is a two state awk toggle:
## awk -v TEMP=/tmp/i3_polybar_utc_${USER} 'BEGIN {{FILE=getline < TEMP < 0 ? "0" : "1"} {if($0==1){STATE=1} else {STATE=0}} {if(STATE==0){system("echo 1 > "TEMP)} else {system("echo 0 > "TEMP)}} }'


## Store toggle status
UTC_TOGGLE="$(cat /tmp/i3_polybar_utc_${USER} 2>/dev/null)"

TZ_TIME="$(date '+%H:%M')"
TZ_DATE="$(date '+%a %d %b')"

UTC_TIME="$(date -u '+%H:%M UTC')"
UTC_DATE="$(date -u '+%F')"


## Set time output based on toggle status
if [ "${UTC_TOGGLE}" = 1 ]; then
    TIME="${UTC_TIME}"
    DATE="${UTC_DATE}"
  else
    TIME="${TZ_TIME}"
    DATE="${TZ_DATE}"
fi


## Format for bar
## NOTE: there is a literal space at the end due to a current bug with the %{O} format
STATUS="%{B#454A4F F#282A2E}%{B#282A2E F#979997}%{F#C5C8C6}${DATE}%{F#B5BD68}%{B#B5BD68 F#282A2E}${TIME} "


## Return results
echo "${STATUS}"
