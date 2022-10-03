#!/bin/sh
## This is my (demuredemeanor) polybar script for checking unread mail count.
## This script checks offlineimap's cache and gets a count of unread messages.

STATUS="$(find ${HOME}/.mail/*/INBOX/new -type f 2>/dev/null | wc -l)"

if [ $STATUS -gt 0 ];then
    ## Set text foreground to yellow
    echo "%{F#DE935F}%{O2}%{O2}${STATUS}%{O2}"
else
    echo "%{F#979997}%{O2}%{O2}"
fi
