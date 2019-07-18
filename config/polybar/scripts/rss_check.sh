#!/bin/sh
## This is my (demuredemeanor) polybar script for checking unread RSS count.
## This script checks newsboat's cache and gets a count of unread messages.


## Possible locations. Prioritise 'oldschool' location.
RSS_PATH1="${HOME}/.newsboat/cache.db"
RSS_PATH2="${HOME}/.local/share/newsboat/cache.db"


## Check unread count
if [ -s "${RSS_PATH1}" ]; then
    STATUS="$(sqlite3 ${RSS_PATH1} 'select sum(unread) from rss_item')"
  elif [ -s "${RSS_PATH2}" ]; then
    STATUS="$(sqlite3 ${RSS_PATH2} 'select sum(unread) from rss_item')"
  else
    STATUS="Missing"
fi


## Return results
echo "${STATUS}"
