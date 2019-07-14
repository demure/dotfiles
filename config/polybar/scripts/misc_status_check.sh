#!/bin/sh
## This is my (demuredemeanor) polybar script for checking miscellaneous statuses.
## Checks:
##      gpg key/smartcard cached
##      screen lock - xss-lock running
##      powersave state
##      vpn state


## Possible PragmataPro icons
## VPN icon:                         
## screen lock icon:                      
## powersave icon:                   


## Initialize variable
STATUS=""


### Check Statuses ### {{{
## GPG key/smartcard cache state. 1 indicates a key is cached (1 tested for).
STATUS_GPG="$({ gpg-connect-agent 'keyinfo --list' /bye 2>/dev/null; gpg-connect-agent 'scd getinfo card_list' /bye 2>/dev/null; } | awk 'BEGIN{CH=0} /^S/ {if($7==1){CH=1}; if($2=="SERIALNO"){CH=1}} END{if($0!=""){print CH} else {print "none"}}')"

## Checks if xss-lock is running. 0 indicates not running (0 tested for).
STATUS_LOCK="$(pgrep -c xss-lock)"

## Powersave state. 0 indicates disabled (0 tested for). Disabling helps with dock and speakers.
STATUS_PS="$(xset -q | awk '/DPMS is/ {if($3=="Disabled"){print 0}else{print 1}}')"

## openvpn check. 1 indicates running (1 tested for).
STATUS_VPN="$(pgrep -c openvpn)"
### End Check Statuses ### }}}


### Set Icons ### {{{
## Note: GPG is first and always shown.
## Items after GPG prepend a space

## Set GPG icon
if [ $STATUS_GPG -eq 1 ];then
    #STATUS+=""
    STATUS+=""
else
    STATUS+=""
fi

## Set lock icon
if [ $STATUS_LOCK -eq 0 ];then
    #STATUS+=" "
    STATUS+=" "
fi

## Set powersave icon
if [ $STATUS_PS -eq 0 ];then
    STATUS+=" "
fi

## Set VPN icon
if [ $STATUS_VPN -eq 1 ];then
    STATUS+=" "
fi
### End Set Icons ### }}}


## Return results
echo "${STATUS}"
