#!/bin/sh
## This is my (demuredemeanor) polybar script for checking External IP
##
## This script checks my computer's external ip, limits the request rate, and handles hiding the ip.
## In addition it will indicate errors, lack of connection, and if the local and external ip match.
## Hiding is convenient when taking screen shots.
## Toggle with:
## awk -v TEMP=/tmp/i3_polybar_ip_toggle_${USER} 'BEGIN {{FILE=getline < TEMP < 0 ? "0" : "1"} {if($0==1){STATE=1} else {STATE=0}} {if(STATE==0){system("echo 1 > "TEMP)} else {system("echo 0 > "TEMP)}} }'


## Variables
TEMP_FILE="/tmp/i3_polybar_ext_ip_${USER}"
TOGGLE_FILE="/tmp/i3_polybar_ip_toggle_${USER}"
WAIT="660"      ## In seconds. dyndns requires a minimum of 10 min between requests.
CUR_TIME="$(date +%s)"
UPDATE=0        ## Default to no update


## Test if an update is needed, or uses the stored external ip
if [ -s "${TEMP_FILE}" ]; then
    FILE_TIME="$(stat -c %Y "${TEMP_FILE}")"
    TIME_DIFF="$(expr ${CUR_TIME} - ${FILE_TIME})"

    if [ "${TIME_DIFF}" -lt "${WAIT}" ]; then
        EXT_IP="$(cat "${TEMP_FILE}")"

        ## Catch bad state
        if [ "${EXT_IP}" == "" ]; then
            UPDATE=1
        fi
      else
        UPDATE=1    ## Run Update
    fi
  else
    UPDATE=1        ## Run Update
fi


## Refreshes external ip
if [ ${UPDATE} -eq 1 ]; then
    ## get ext ip
    EXT_IP="$(wget --no-proxy http://checkip.dyndns.org/ -q -O - | awk '{match($0, /Address: ([0-9.]+)/,m); if(m[1]!=""){print m[1]} else {print "err"}}')"

    ## Write to temp file
    echo "${EXT_IP}" > "${TEMP_FILE}"
fi


## Set error icon
if [ "${EXT_IP}" == "err" ]; then
    EXT_IP=""
fi


## Set no-connection icon, and save space if local and ext match.
LOCAL_IP="$(ip address show up scope global | awk '/inet[^6]/ {match($2, /(.*)\/.*/, m); print m[1]}')"
if [ "${LOCAL_IP}" == "" ]; then
    EXT_IP="×"
  elif [ "${LOCAL_IP}" == "${EXT_IP}" ]; then
    EXT_IP="same"
fi


## Check Toggle State
if [ -s "${TOGGLE_FILE}" ]; then
    TOGGLE="$(cat "${TOGGLE_FILE}")"

    if [ "${TOGGLE}" -eq 1 ]; then
        EXT_IP=""
    fi
fi


## Return results
echo "${EXT_IP}"
