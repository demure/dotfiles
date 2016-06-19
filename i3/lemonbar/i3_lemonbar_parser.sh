#!/bin/bash
#
# Input parser for i3 bar
# 14 ago 2015 - Electro7
# config
. $(dirname $0)/i3_lemonbar_config

# min init
irc_n_high=0
title="%{F${color_head} B${color_sec_b2}}${sep_right}%{F${color_head} B${color_sec_b2}%{T2} ${icon_prog} %{F${color_sec_b2} B-}${sep_right}%{F- B- T1}"

# parser
while read -r line ; do
	case $line in
		### SYS Case ### {{{
		SYS*)
			## conky=, 0=wday, 1=mday, 2=month, 3=time, 4=cpu, 5=mem, 6=disk /,
			## 7=comp temp, 8-9=up/down wlan, 10-11=up/down eth, 12=eth ip,
			## 13=wlan ip, 14=wifi %, 15=battery %, 16=battery stat,
			## Things to add: Make HD use show free? Network weechat check?

			sys_arr=(${line#???})

			### Time and Date ### {{{
			## Date
			if [ ${res_w} -gt 1024 ]; then
				date="${sys_arr[0]} ${sys_arr[1]} ${sys_arr[2]}"
			  else
				date="${sys_arr[1]} ${sys_arr[2]}"
			fi
			date="%{F${color_sec_b1}}${sep_left}%{F${color_icon} B${color_sec_b1}} %{T2}${icon_clock}%{F- T1} ${date}"
			## Time
			time="%{F${color_head}}${sep_left}%{F${color_back} B${color_head}} ${sys_arr[3]} %{F- B-}"
			### End Time ### }}}

			### CPU ### {{{
			if [ ${sys_arr[4]} -gt ${cpu_alert} ]; then
				cpu_cback=${color_cpu}; cpu_cicon=${color_back}; cpu_cfore=${color_back};
			  else
				cpu_cback=${color_sec_b2}; cpu_cicon=${color_icon}; cpu_cfore=${color_fore};
			fi
			cpu="%{F${cpu_cback}}${sep_left}%{F${cpu_cicon} B${cpu_cback}} %{T2}${icon_cpu}%{F${cpu_cfore} T1} ${sys_arr[4]}%"
			### End CPU ### }}}

			### Memory and Disk ### {{{
			## mem (ram)
			mem="%{F${cpu_cicon}}${sep_l_left} %{T2}${icon_mem}%{F${cpu_cfore} T1} ${sys_arr[5]}%"
			## disk /
			diskr="%{F${color_sec_b1}}${sep_left}%{F${color_icon} B${color_sec_b1}} %{T2}${icon_hd}%{F- T1} ${sys_arr[6]}%"
			### End Memory ### }}}

			### Net Speed ### {{{
			## made to replace WLAN and Eth sections
			## Will prefer eth0 if up
			if [ "${sys_arr[10]}" == "down" ]; then
				if [ "${sys_arr[8]}" == "down" ];then
					nets_dv="×"; nets_uv="×";
					nets_cback=${color_sec_b1}; nets_cicon=${color_disable}; nets_cfore=${color_disable};
				  else
					nets_dv=${sys_arr[8]}K; nets_uv=${sys_arr[9]}K;
					if [ ${nets_dv:0:-3} -gt ${net_alert} ] || [ ${nets_uv:0:-3} -gt ${net_alert} ]; then
						nets_cback=${color_net}; nets_cicon=${color_back}; nets_cfore=${color_back};
					  else
						nets_cback=${color_sec_b1}; nets_cicon=${color_icon}; nets_cfore=${color_fore};
					fi
				fi
			  else
				nets_dv=${sys_arr[10]}K; nets_uv=${sys_arr[11]}K;
				if [ ${nets_dv:0:-3} -gt ${net_alert} ] || [ ${nets_uv:0:-3} -gt ${net_alert} ]; then
					nets_cback=${color_net}; nets_cicon=${color_back}; nets_cfore=${color_back};
				  else
					nets_cback=${color_sec_b1}; nets_cicon=${color_icon}; nets_cfore=${color_fore};
				fi
			fi
			nets_d="%{F${nets_cback}}${sep_left}%{F${nets_cicon} B${nets_cback}} %{T2}${icon_dl}%{F${nets_cfore} T1} ${nets_dv}"
			nets_u="%{F${nets_cicon}}${sep_l_left} %{T2}${icon_ul}%{F${nets_cfore} T1} ${nets_uv}"
			### End Net Speed ### }}}

			### Battery ### {{{
			## Icon         0         1         2         3          4
			## Bat >=      NA        11        37        63         90
			## Range     0-10     11-36     37-62     63-89     90-100

			if [ ${thinkpad_battery} -ne 1 ]; then
				## Set icons
				## This is 'hard' coded, instead of in the conf, due to font.
				## It will take user intervention if they have a different number of icons
				if [ ${sys_arr[15]} -ge 90 ]; then
					bat_icon=${icon_bat4};
				  elif [ ${sys_arr[15]} -ge 63 ]; then
					bat_icon=${icon_bat3};
				  elif [ ${sys_arr[15]} -ge 37 ]; then
					bat_icon=${icon_bat2};
				  elif [ ${sys_arr[15]} -ge 11 ]; then
					bat_icon=${icon_bat1};
				  else
					bat_icon=${icon_bat0};
				fi

				## Set Colors
				if [ ${sys_arr[15]} -le ${bat_alert_low} ]; then
					bat_cicon=${color_icon}; bat_cfore=${color_fore}; bat_cback=${color_bat_low};
				  elif [ ${sys_arr[15]} -le ${bat_alert_mid} ]; then
					bat_cicon=${color_icon}; bat_cfore=${color_fore}; bat_cback=${color_bat_mid};
				  elif [ ${sys_arr[15]} -le ${bat_alert_high} ]; then
					bat_cicon=${color_bat_high}; bat_cfore=${color_fore}; bat_cback=${color_sec_b1};
				  else
					bat_cicon=${color_icon}; bat_cfore=${color_fore}; bat_cback=${color_sec_b1};
				fi

				## Set charging icon
				if [ ${sys_arr[16]} == "C" ] || [ ${sys_arr[16]} == "F" ]; then
					bat_icon=${icon_bat_plug}; bat_cicon=${color_bat_plug};
				fi
				bat="%{F${bat_cback}}${sep_left}%{F${bat_cicon} B${bat_cback}} %{T2}${bat_icon}%{F- T1} ${sys_arr[15]}%"
			fi
			### End Battery ### }}}

			### Temperature ### {{{
			if [ ${sys_arr[7]} -gt ${temp_alert} ]; then
				temp_cback=${color_temp}; temp_cicon=${color_back}; temp_cfore=${color_back};
			  else
				temp_cback=${color_sec_b2}; temp_cicon=${color_icon}; temp_cfore=${color_fore};
			fi
			temp="%{F${temp_cback}}${sep_left}%{F${temp_cicon} B${temp_cback}} %{T2}${icon_temp}%{F${temp_cfore} T1} ${sys_arr[7]}F"
			### End Temp ### }}}

			### Local IP ### {{{
			## To save space, I don't want to give both eth0 and wlan0 spots
			## So I will make eth0 > wlan0, as if my laptop has eth, I probably want it.
			## eth ${sys_arr[11]} wlan ${sys_arr[12]}
			if [ ${sys_arr[12]} != "down" ]; then
				lip_select="${sys_arr[12]}"; lip_icon="${icon_local_eth}";
			  elif [ ${sys_arr[13]} != "down" ]; then
				lip_select="${sys_arr[13]}"; lip_icon="${icon_local_wifi}";
			  else
				lip_select="No IP"; lip_icon="${icon_local_out}";
			fi
			local_ip="%{F${color_sec_b1}}${sep_left}%{F${color_icon} B${color_sec_b1}} %{T2}${lip_icon}%{F- T1} ${lip_select}"
			### End Local IP ### }}}

			### Wifi Percent ### {{{
			if [ ${sys_arr[13]} != "down" ]; then
			wifi="%{F${color_icon}}${sep_l_left}%{F${color_icon} B${color_sec_b1}} %{T2}${icon_wifi}%{F- T1} ${sys_arr[14]}%"
			  else
				wifi=""
			fi
			### End Wifi Percent ### }}}

			;;
		### End SYS Case ### }}}

		### External IP Case ### {{{
		EXT*)
			# External IP
			ext_arr="${line#???}"
			if [ "${lip_select}" = "No IP" ]; then
				ext_ip="%{F${color_sec_b2}}${sep_left}%{F${color_icon} B${color_sec_b2}} %{T2}${icon_ext_ip}%{F- T1} No IP"
			  elif [ "${lip_select}" = "${ext_arr}" ]; then
				ext_ip="%{F${color_sec_b2}}${sep_left}%{F${color_icon} B${color_sec_b2}} %{T2}${icon_ext_ip}%{F- T1} Same"
			  else
				ext_ip="%{F${color_sec_b2}}${sep_left}%{F${color_icon} B${color_sec_b2}} %{T2}${icon_ext_ip}%{F- T1} ${ext_arr}"
			fi
			;;
		### End External IP Case ### }}}

		### Volume Case ### {{{
		VOL*)
			# Volume
			vol="%{F${color_sec_b2}}${sep_left}%{F${color_icon} B${color_sec_b2}} %{T2}${icon_vol}%{F- T1} ${line#???}"
			;;
		### End Vol Case ### }}}

		### Brightness Case ### {{{
		BRI*)
			# Brightness
			bri="%{F${color_icon}}${sep_l_left}%{F${color_icon} B${color_sec_b2}} %{T2}${icon_bri}%{F- T1} ${line#???}%"
			;;
		### End Vol Case ### }}}

		### Offlineimap Case ### {{{
		EMA*)
			email_arr="${line#???}"
			if [ "${email_arr}" != "0" ]; then
				mail_cback=${color_mail}; mail_cicon=${color_back}; mail_cfore=${color_back}
			  else
				mail_cback=${color_sec_b2}; mail_cicon=${color_icon}; mail_cfore=${color_fore}
			fi
			email="%{F${mail_cback}}${sep_left}%{F${mail_cicon} B${mail_cback}} %{T2}${icon_mail}%{F${mail_cfore} T1} ${email_arr}"
			;;
		### End Offlineimp Case ### }}}

		### GPG Case ### {{{
		GPG*)
			gpg_arr=(${line#???})
			if [ "${gpg_arr}" = "1" ]; then
				lock="${icon_gpg_unlocked}"
			  else
				lock="${icon_gpg_locked}"
			fi
			gpg="%{F${color_icon}}${sep_l_left}%{B${color_sec_b2}}%{F${color_icon} B${color_sec_b2}} %{T2}${icon_gpg}%{F${color_fore} T1} ${lock}"
			;;
		### End GPG Case ### }}}

		### Thinkpad Multi Battery ### {{{
		## Icon         0         1         2         3          4
		## Bat >=      NA        11        37        63         90
		## Range     0-10     11-36     37-62     63-89     90-100

		TMB*)
			## Now that I have >12 hours of battery, I don't feel the need for as drastic color thresholds.
			## I will have colors only at much lower percentages.

			if [ ${thinkpad_battery} -eq 1 ]; then
			tmb_arr_perc=$(echo ${line#???} | cut -f1 -d\ )
			tmb_arr_status=$(echo ${line#???} | cut -f2 -d\ )
			tmb_arr_time=$(echo ${line#???} | cut -f3 -d\ )
				## Set icon only
				## This is 'hard' coded, instead of in the conf, due to font.
				## It will take user intervention if they have a different number of icons
				if [ ${tmb_arr_perc} -ge 90 ]; then
					bat_icon=${icon_bat4};
				  elif [ ${tmb_arr_perc} -ge 63 ]; then
					bat_icon=${icon_bat3};
				  elif [ ${tmb_arr_perc} -ge 37 ]; then
					bat_icon=${icon_bat2};
				  elif [ ${tmb_arr_perc} -ge 11 ]; then
					bat_icon=${icon_bat1};
				  else
					bat_icon=${icon_bat0};
				fi

				## Set Colors
				if [ ${tmb_arr_perc} -le ${bat_alert_low} ]; then
					bat_cicon=${color_icon}; bat_cfore=${color_fore}; bat_cback=${color_bat_low};
				  elif [ ${tmb_arr_perc} -le ${bat_alert_mid} ]; then
					bat_cicon=${color_icon}; bat_cfore=${color_fore}; bat_cback=${color_bat_mid};
				  elif [ ${tmb_arr_perc} -le ${bat_alert_high} ]; then
					bat_cicon=${color_bat_high}; bat_cfore=${color_fore}; bat_cback=${color_sec_b1};
				  else
					bat_cicon=${color_icon}; bat_cfore=${color_fore}; bat_cback=${color_sec_b1};
				fi

				## Set charging icon
				if [ ${tmb_arr_status} != "D" ]; then
					bat_icon=${icon_bat_plug}; bat_cicon=${color_bat_plug};
				fi
				bat="%{F${bat_cback}}${sep_left}%{F${bat_cicon} B${bat_cback}} %{T2}${bat_icon}%{F- T1} ${tmb_arr_perc}%"
				bat_time="%{F${color_icon}}${sep_l_left}%{F${color_icon} B${color_sec_b1}} %{T2}${icon_bat_time}%{F- T1} ${tmb_arr_time}"
			fi
			;;
		### End Thinkpad Multi Battery ### }}}

		#### IRC Case ### {{{
		#IRC*)
			## IRC highlight (script irc_warn)
			#if [ "${line#???}" != "0" ]; then
				#((irc_n_high++)); irc_high="${line#???}";
				#irc_cback=${color_chat}; irc_cicon=${color_back}; irc_cfore=${color_back}
			  #else
				#irc_n_high=0; [ -z "${irc_high}" ] && irc_high="none";
				#irc_cback=${color_sec_b2}; irc_cicon=${color_icon}; irc_cfore=${color_fore}
			#fi
			#irc="%{F${irc_cback}}${sep_left}%{F${irc_cicon} B${irc_cback}} %{T2}${icon_chat}%{F${irc_cfore} T1} ${irc_n_high} %{F${irc_cicon}}${sep_l_left} %{T2}${icon_contact}%{F${irc_cfore} T1} ${irc_high}"
			#;;
		#### End IRC Case ### }}}

		### Control Pianobar Case ### {{{
		CPB*)
			# Music
			cpb_arr=(${line#???})
			if [ -z "${line#???}" ]; then
				song="none";
			  #elif [ "${cpb_arr[0]}" == "error:" ]; then
				#song="mpd off";
			  else
				song="${line#???}";
			fi
			cpb="%{F${color_sec_b2}}${sep_left}%{B${color_sec_b2}}%{F${color_sec_b1}}${sep_left}%{F${color_icon} B${color_sec_b1}} %{T2}${icon_music}%{F${color_fore} T1} ${song}"
			;;
		### End Control Pianobar Case ### }}}

		### Workspace Case ### {{{
		WSP*)
			## I3 Workspaces
			wsp="%{F${color_back} B${color_head}} %{T2}${icon_wsp}%{T1}"
			set -- ${line#???}
			while [ $# -gt 0 ] ; do
				case $1 in
				 FOC*)
					wsp="${wsp}%{F${color_head} B${color_wsp}}${sep_right}%{F${color_back} B${color_wsp} T1} ${1#???} %{F${color_wsp} B${color_head}}${sep_right}"
					;;
				 INA*|URG*|ACT*)
					wsp="${wsp}%{F${color_disable} T1} ${1#???} "
					;;
				esac
				shift
			done
			;;
		### End Workspace Case ### }}}

		### Window Case ### {{{
		WIN*)
			# window title
			title=$(xprop -id ${line#???} | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
			title="%{F${color_head} B${color_sec_b2}}${sep_right}%{F${color_head} B${color_sec_b2} T2} ${icon_prog} %{F${color_sec_b2} B-}${sep_right}%{F- B- T1} ${title}"
			;;
		### End Window Case ### }}}
	esac

	# And finally, output
	printf "%s\n" "%{l}${wsp}${title} %{r}${cpb}${stab}${email}${stab}${gpg}${stab}${local_ip}${stab}${wifi}${stab}${ext_ip}${stab}${bat}${stab}${bat_time}${stab}${cpu}${stab}${mem}${stab}${diskr}${stab}${temp}${stab}${nets_d}${stab}${nets_u}${stab}${vol}${stab}${bri}${stab}${date}${stab}${time}"
	#printf "%s\n" "%{l}${wsp}${title}"
done
