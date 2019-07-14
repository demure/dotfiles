#!/bin/sh
## This is my (demuredemeanor) polybar script for checking GPG
## This script handles checking if a GPG key/smartcard is in cache
## Note: also done by misc_status_check.sh

## Get status
STATUS="$({ gpg-connect-agent 'keyinfo --list' /bye 2>/dev/null; gpg-connect-agent 'scd getinfo card_list' /bye 2>/dev/null; } | awk 'BEGIN{CH=0} /^S/ {if($7==1){CH=1}; if($2=="SERIALNO"){CH=1}} END{if($0!=""){print CH} else {print "none"}}')"

## Return icon results
if [ $STATUS -eq 1 ];then
    echo ""
else
    echo ""
fi
