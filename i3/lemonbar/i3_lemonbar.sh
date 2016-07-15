#!/bin/bash

## I3 bar with https://github.com/LemonBoy/bar
##
## Based on Electro7's work
## Modded by demure

. $(dirname $0)/i3_lemonbar_config

if [ $(pgrep -cx $(basename $0)) -gt 1 ] ; then
	printf "%s\n" "The status bar is already running." >&2
	exit 1
fi

trap 'trap - TERM; kill 0' INT TERM QUIT EXIT

[ -e "${panel_fifo}" ] && rm "${panel_fifo}"
mkfifo "${panel_fifo}"

### EVENTS METERS

## Window title, "WIN"
xprop -spy -root _NET_ACTIVE_WINDOW | sed -un 's/.*\(0x.*\)/WIN\1/p' > "${panel_fifo}" &

## i3 Workspaces, "WSP"
## TODO : Restarting I3 breaks the IPC socket con. :(
$(dirname $0)/i3_workspaces.pl > "${panel_fifo}" &

# IRC, "IRC"
# only for init
#~/bin/irc_warn &

## Conky, "SYS"
conky -c $(dirname $0)/i3_lemonbar_conky > "${panel_fifo}" &

### UPDATE INTERVAL METERS
cnt_vol=${upd_vol}
cnt_bri=${upd_bri}
cnt_mail=${upd_mail}
cnt_mmpd=${upd_mmpd}
cnt_ext_ip=${upd_ext_ip}
cnt_gpg=${upd_gpg}
cnt_tmb=${upd_tmb}

while :; do

	## Volume, "VOL"
	if [ $((cnt_vol++)) -ge ${upd_vol} ]; then
		amixer get Master | awk -F'[]%[]' '/%/ {STATE=$5; VOL=$2} END {if (STATE == "off") {print "VOL×\n"} else {printf "VOL%d%%\n", VOL}}' > "${panel_fifo}" &
		cnt_vol=0
	fi

	## Brightness, "BRI"
	if [ $((cnt_bri++)) -ge ${upd_bri} ]; then
		## xbacklight doesn't work as this doesn't have xrandr access while running as the bar?
		paste /sys/class/backlight/intel_backlight/{actual_brightness,max_brightness} | awk '{BRIGHT=$1/$2*100} END {printf "%s%.f\n", "BRI", BRIGHT}' > "${panel_fifo}" &
		cnt_bri=0
	fi

	## Offlineimap, "EMA"
	if [ $((cnt_mail++)) -ge ${upd_mail} ]; then
		printf "%s%s\n" "EMA" "$(find $HOME/.mail/*/INBOX/new -type f 2>/dev/null | wc -l)" > "${panel_fifo}"
		cnt_mail=0
	fi

	## Multi Music Player Display
	if [ $((cnt_mmpd++)) -ge ${upd_mmpd} ]; then
		mmpd_check="$(grep -qxs 1 $HOME/.config/pianobar/isplaying && cat $HOME/.config/pianobar/nowplaying || echo 'none')"
		if [ "${mmpd_check}" != "none" ]; then
			printf "%s%s\n" "MMP" "${mmpd_check}" > "${panel_fifo}"
		  else
		mmpd_check="$(cmus-remote -Q 2>/dev/null | awk 'BEGIN {STATUS=0;STREAM=0;TITLE=0;ARTIST=0} {match($0, /^(status|stream|tag title|tag artist)\s(.*)/, m); if(m[1]=="status"){STATUS=m[2]};if(m[1]=="stream"){STREAM=m[2]}; if(m[1]=="tag title"){TITLE=m[2]}; if(m[1]=="tag artist"){ARTIST=m[2]}} END {if(STATUS!=0){if(STATUS=="playing"){if(STREAM!=0){print STREAM} else if(ARTIST!=0){print ARTIST " - " TITLE} else if(TITLE!=0){print TITLE}else {print "cmus: no meta data"}} else if(STATUS=="paused"){print "cmus: paused"} else {print "none"}} else {print "none"}}')"
			if [ "${mmpd_check}" != "none" ]; then
				printf "%s%s\n" "MMP" "${mmpd_check}" > "${panel_fifo}"
			  else
				## This makes scaling easier
				printf "%s%s\n" "MMP" "none" > "${panel_fifo}"
			fi
		fi
	fi

	## Thinkpad Milti Battery, "TMB"
	if [ ${thinkpad_battery} -eq 1 ]; then
		if [ $((cnt_tmb++)) -ge ${upd_tmb} ]; then
			printf "%s%s%s\n" "TMB" "$(paste -d = /sys/class/power_supply/BAT{0..1}/uevent | awk '/ENERGY_FULL=/||/ENERGY_NOW=/||/STATUS/ {split($0,a,"="); if(a[2]~/Discharging/||a[4]~/Discharging/){CHARGE="D"} else if(a[2]~/Charging/||a[4]~/Charging/){CHARGE="C"} else if (a[2]~/Full/||a[4]~/Full/){CHARGE="F"}; if(a[1]~/FULL/){FULL=a[2]+a[4]}; if(a[1]~/NOW/){NOW=a[2]+a[4]};} END {PERC=(NOW/FULL)*100; printf("%.0f %s", PERC, CHARGE)}')" "$(acpi -b | awk '{if($5!=""){print " " $5}}')" > "${panel_fifo}"
			cnt_tmb=0
		fi
	fi

	## GPG Check, "GPG"
	if [ $((cnt_gpg++)) -ge ${upd_gpg} ]; then
		export DISPLAY=''
		printf "%s%s\n" "GPG" "$(gpg-connect-agent 'keyinfo --list' /bye 2>/dev/null | awk 'BEGIN{CACHED=0} /^S/ {match($0, /S\sKEYINFO\s\S+\s\S\s\S+\s\S+\s(\S)\s\S\s\S+\s\S+\s\S/, m); if(m[1]==1){CACHED=1}} END{print CACHED}')" > "${panel_fifo}"
		cnt_gpg=0
	fi

	## External IP
	if [ $((cnt_ext_ip++)) -ge ${upd_ext_ip} ]; then
		printf "%s%s\n" "EXT" "$(wget --no-proxy http://checkip.dyndns.org/ -q -O - | grep -Eo '\<[[:digit:]]{1,3}(\.[[:digit:]]{1,3}){3}\>' || echo 'err')" > "${panel_fifo}"
		cnt_ext_ip=0
	fi

	## Finally, wait 1 second
	sleep 1s;

done &

#### LOOP FIFO

cat "${panel_fifo}" | $(dirname $0)/i3_lemonbar_parser.sh \
	| lemonbar -p -f "${font}" -f "${iconfont}" -g "${geometry}" -B "${color_back}" -F "${color_fore}" &

wait

