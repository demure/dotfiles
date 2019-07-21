#!/bin/sh
## This is my (demuredemeanor) polybar script for toggling External IP display.
## This script handles the awk toggle for ext ip, since polybar doesn't like the raw command for its click execs

awk -v TEMP=/tmp/i3_polybar_ipv6_toggle_${USER} 'BEGIN {{FILE=getline < TEMP < 0 ? "0" : "1"} {if($0==1){STATE=1} else {STATE=0}} {if(STATE==0){system("echo 1 > "TEMP)} else {system("echo 0 > "TEMP)}} }'
