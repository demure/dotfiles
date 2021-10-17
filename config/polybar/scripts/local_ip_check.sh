#!/bin/sh
## This is my (demuredemeanor) polybar script for checking Local IP
##
## This script checks my computer's local ip, handles both eth and wlan, and handles hiding the ip.
## In addition it will indicate errors, lack of connection, and wifi signal strength.
## Hiding is convenient when taking screen shots.
## Toggle with:
## awk -v TEMP=/tmp/i3_polybar_ip_toggle_${USER} 'BEGIN {{FILE=getline < TEMP < 0 ? "0" : "1"} {if($0==1){STATE=1} else {STATE=0}} {if(STATE==0){system("echo 1 > "TEMP)} else {system("echo 0 > "TEMP)}} }'


## Variables
TOGGLE_SHOW_FILE="/tmp/i3_polybar_ip_toggle_${USER}"
TOGGLE_IPV6_FILE="/tmp/i3_polybar_ipv6_toggle_${USER}"


## Get Data
## Contains docker, qemu, tun/tap interface mitigation
LOCAL_IP="$(ip address show up scope global | awk '/inet[^6]/&&!/(docker|virbr|tun|tap|wg)[0-9]+$/ {match($2, /(.*)\/.*/, m); print m[1]}')"
LOCAL_IPV6="$(ip address show up scope global | awk '/inet6/&&!/(docker|virbr|tun|tap|wg)[0-9]+$/ {match($2, /(.*)\/.*/, m); print m[1]}')"
WIFI_SIG="$(iwconfig 2>/dev/null | awk '/Link/ {match($2, /\w+=([0-9]+)\/([0-9]+)/, m)} END {if(m[1]!=""&&m[2]!=""){print int((m[1] / m[2]) * 100)}}')"


## Set connection icon
if [ "${LOCAL_IP}" != "" ]; then
    if [ "${WIFI_SIG}" = "" ]; then
        ## Set eth icon
        ICON=""
      else
        ## Set wlan icon
        ICON=""
    fi
else
    ## Set no ip icon
    ICON=""
fi


## Set no-connection output
if [ "${LOCAL_IP}" = "" ]; then
    LOCAL_IP="×"
fi


## Prep wifi signal display, deals with icon color
if [ "${WIFI_SIG}" != "" ]; then
    WIFI_SIG="%{F#979997} %{F#C5C8C6}${WIFI_SIG}%"
fi


## Set no-ipv6 message. Thought process is that ipv4 is default, and it is possible to have ipv4 sans ipv6
if [ "${LOCAL_IPV6}" = "" ]; then
    LOCAL_IPV6="No IPv6"
fi


## Check Toggle IPv6 State
if [ -s "${TOGGLE_IPV6_FILE}" ]; then
    TOGGLE_IPV6="$(cat "${TOGGLE_IPV6_FILE}")"

    if [ "${TOGGLE_IPV6}" -eq 1 ]; then
        LOCAL_IP="${LOCAL_IPV6}"
    fi
fi

## Check Toggle Show State
if [ -s "${TOGGLE_SHOW_FILE}" ]; then
    TOGGLE_SHOW="$(cat "${TOGGLE_SHOW_FILE}")"

    if [ "${TOGGLE_SHOW}" -eq 1 ]; then
        LOCAL_IP=""
    fi
fi


## Return results
## Deals with icon color.
echo "%{F#979997}${ICON}%{F#C5C8C6}${LOCAL_IP}${WIFI_SIG}"
