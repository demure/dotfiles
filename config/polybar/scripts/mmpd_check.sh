#!/bin/sh
## This is my (demuredemeanor) polybar script for handling Multi Music Player Display.
## Displays playing song for:
##      (control)pianobar
##      cmus
##      mpd
##      mocp
##      audacios


## Initialize variable
MMPD_CHECK="none"


### Music Player Checks ### {{{
## NOTE: These are listed in order of what I might actually use (so things I don't are later)
## NOTE: if an earlier music player reports a song (or paused) later players will not be tested

## (control)pianobar
if [ "${MMPD_CHECK}" == "none" ] && [ $(command -v pianobar) ]; then
    MMPD_CHECK="$(grep -qxs 1 ${HOME}/.config/pianobar/isplaying && cat ${HOME}/.config/pianobar/nowplaying || echo 'none')"
fi

## cmus
if [ "${MMPD_CHECK}" == "none" ] && [ $(command -v cmus-remote) ]; then
    MMPD_CHECK="$(cmus-remote -Q 2>/dev/null | awk 'BEGIN {STATUS=0;STREAM=0;TITLE=0;ARTIST=0} {match($0, /^(status|stream|tag title|tag artist)\s(.*)/, m); if(m[1]=="status"){STATUS=m[2]};if(m[1]=="stream"){STREAM=m[2]}; if(m[1]=="tag title"){TITLE=m[2]}; if(m[1]=="tag artist"){ARTIST=m[2]}} END {if(STATUS!=0){if(STATUS=="playing"){if(STREAM!=0){print STREAM} else if(ARTIST!=0&&TITLE!=0){print ARTIST " - " TITLE} else if(TITLE!=0){print TITLE}else {print "cmus: no meta data"}} else if(STATUS=="paused"){print "cmus: paused"} else {print "none"}} else {print "none"}}')"
fi

## mpd
if [ "${MMPD_CHECK}" == "none" ] && [ $(command -v mpc) ]; then
    MMPD_CHECK="$(mpc status 2>/dev/null | awk 'BEGIN {STATUS=0;INFO=0} !/^volume/ {match($0, /^(\w+.*)/, p); match($0, /(\[playing\]|\[paused\])/, m); if(m[0]!=""){STATUS=m[1]}; if(p[0]!=""){INFO=p[0]}} END {if(STATUS!=0){if(STATUS=="[paused]"){print "mpd: paused"} else {print INFO}} else {print "none"}}')"
fi

## mocp
if [ "${MMPD_CHECK}" == "none" ] && [ $(command -v mocp) ]; then
    MMPD_CHECK="$(mocp --info 2>/dev/null | awk 'BEGIN {STATE=0; TITLE=0; ARTIST=0} {match($0, /^(State|Title|Artist):\s(.*)/, m); if(m[1]=="State"){STATE=m[2]}; if(m[1]=="Artist"&&m[2]!=""){ARTIST=m[2]}; if(m[1]=="Title"&&m[2]!=""){TITLE=m[2]}} END {if(STATE!=0){if(STATE=="PLAY"){if(TITLE!=0){print TITLE} else {print "mocp: no meta data"}} else if(STATE=="PAUSE"){print "mocp: paused"} else {print "none"}} else {print "none"}}')"
fi

## audacios
if [ "${MMPD_CHECK}" == "none" ] && [ $(command -v audtool) ]; then
    MMPD_CHECK="$(audtool --playback-status --current-song 2>/dev/null | awk 'BEGIN {STATUS=0; INFO=0} {if($0=="playing"||$0=="paused"){STATUS=$0}; if(STATUS=="playing"){INFO=$0}} END {if(INFO!=0){print INFO} else if(STATUS=="paused"){print "audacios: paused"} else {print "none"}}')"
fi
### End Music Player Checks ### }}}


## If no music, return fancy none icon
if [ "${MMPD_CHECK}" == "none" ]; then
    MMPD_CHECK="×"
fi


## Return results
echo "${MMPD_CHECK}"
