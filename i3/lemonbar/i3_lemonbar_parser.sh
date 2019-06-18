#!/bin/bash

## Input parser for i3 bar
##
## Based on Electro7's work
## Highly Modded by demure

## config
. $(dirname $0)/i3_lemonbar_config

## min init
irc_n_high=0
title="%{F${color_head} B${color_sec_b2}}${sep_right}%{F${color_head} B${color_sec_b2}%{T2} ${icon_prog} %{F${color_sec_b2} B-}${sep_right}%{F- B- T1}"

## parser
while read -r line ; do
    case ${line} in
        ### SYS Case ### {{{
        SYS*)
            ## conky=, 0-1=up/down wlan, 2-3=up/down eth, 5=cpu

            sys_arr=(${line#???})

            ### CPU ### {{{
            if [ ${sys_arr[4]} -gt ${cpu_alert} ]; then
                cpu_set_back=${color_cpu}; cpu_cicon=${color_back}; cpu_cfore=${color_back};
              else
                cpu_set_back=${cpu_cback}; cpu_cicon=${color_icon}; cpu_cfore=${color_fore};
            fi
            cpu="%{F${cpu_set_back}}${sep_left}%{F${cpu_cicon} B${cpu_set_back}} %{T2}${icon_cpu}%{F${cpu_cfore} T1} ${sys_arr[4]}%"
            ### End CPU ### }}}

            ### Net Speed ### {{{
            ## made to replace WLAN and Eth sections
            ## Will prefer eth0 if up
            if [ "${sys_arr[2]}" == "down" ]; then
                if [ "${sys_arr[0]}" == "down" ];then
                    nets_dv="×"; nets_uv="×";
                    nets_cback=${color_sec_b1}; nets_cicon=${color_disable}; nets_cfore=${color_disable};
                  else
                    nets_dv=${sys_arr[0]}K; nets_uv=${sys_arr[1]}K;
                    if [ ${nets_dv:0:-3} -gt ${net_alert} ] || [ ${nets_uv:0:-3} -gt ${net_alert} ]; then
                        nets_cback=${color_net}; nets_cicon=${color_back}; nets_cfore=${color_back};
                      else
                        nets_cback=${color_sec_b1}; nets_cicon=${color_icon}; nets_cfore=${color_fore};
                    fi
                fi
              else
                nets_dv=${sys_arr[2]}K; nets_uv=${sys_arr[3]}K;
                if [ ${nets_dv:0:-3} -gt ${net_alert} ] || [ ${nets_uv:0:-3} -gt ${net_alert} ]; then
                    nets_cback=${color_net}; nets_cicon=${color_back}; nets_cfore=${color_back};
                  else
                    nets_cback=${color_sec_b1}; nets_cicon=${color_icon}; nets_cfore=${color_fore};
                fi
            fi
            nets_d="%{F${nets_cback}}${sep_left}%{F${nets_cicon} B${nets_cback}} %{T2}${icon_dl}%{F${nets_cfore} T1} ${nets_dv}"
            nets_u="%{F${nets_cicon}}${sep_l_left} %{T2}${icon_ul}%{F${nets_cfore} T1} ${nets_uv}"
            ### End Net Speed ### }}}
            ;;
        ### End SYS Case ### }}}

        ### Time and Date Case ### {{{
        TIM*)
            ## Display Time and Date
            ## Seems to need a hand to be treated as an array...
            read -r -a time_arr <<< "${line#???}"
            #time_arr="${line#???}"

            ## Set Time Var
            time="${time_arr[3]}"

            ## Set Date Var
            if [ ${res_w} -gt 1024 ]; then
                date="${time_arr[0]} ${time_arr[1]} ${time_arr[2]}"
              else
                date="${time_arr[1]} ${time_arr[2]}"
            fi

            ## Grab UTC toggle state, and replace time if set on
            utc_toggle="$(cat /tmp/i3_lemonbar_utc_${USER} 2>/dev/null)"
            if [ "${utc_toggle}" == 1 ]; then
                time="${utc_time}"
                date="${utc_date}"
            fi

            date="%{F${date_cback}}${sep_left}%{F${color_icon} B${date_cback}} %{T2}${icon_time}%{F- T1} ${date}"
            ## Time
            time="%{F${color_head}}${sep_left}%{F${color_back} B${color_head}} ${time} %{F- B-}"
            ;;
        ### End Time and Date Case ### }}}

        ### UTC Time Case ### {{{
        UTC*)
            ## Display Ram use
            ## Seems to need a hand to be treated as an array...
            read -r -a utc_arr <<< "${line#???}"
            #time_arr="${line#???}"

            ## UTC Date
            utc_date="${utc_arr[0]}"
            ## UTC Time
            utc_time="${utc_arr[1]} ${utc_arr[2]}"
            ;;
        ### UTC Time Case ### }}}

        ### Disk Usage Case ### {{{
        DIC*)
            ## Display Disk use
            disk_arr="${line#???}"
            diskr="%{F${disk_cback}}${sep_left}%{F${color_icon} B${disk_cback}} %{T2}${icon_disk}%{F- T1} ${disk_arr}"
            ;;
        ### End Disk Usage Case ### }}}

        ### MEM Usage Case ### {{{
        MEM*)
            ## Display Mem use
            mem_arr="${line#???}"
            mem="%{F${cpu_cicon}}${sep_l_left} %{T2}${icon_mem}%{F${cpu_cfore} T1} ${mem_arr}"
            ;;
        ### End MEM Usage Case ### }}}

        ### Network Case ### {{{
        NET*)
            ## Receives either eth or wireless ip, and interface, and signal.
            ## Unfortunately, this will likely default to the last valid entry.
            read -r -a net_arr <<< "${line#???}"
            net_arr_ip="${net_arr[0]}"
            net_arr_inter="${net_arr[1]}"
            net_arr_ipv6="${net_arr[2]}"
            net_arr_signal="${net_arr[3]}"
            net_arr_vpn="${net_arr[4]}"

            ## Local IP
            if [ "${net_arr_ip}" != "none" ]; then
                if [[ ${net_arr_inter} =~ eth ]]; then
                    net_icon="${icon_local_eth}";
                  else
                    net_icon="${icon_local_wifi}";
                fi
              else
                net_arr_ip="No IP"; net_icon="${icon_local_out}";
            fi
            #local_ip_cback=${color_sec_b1}
            local_ip="%{F${local_ip_cback}}${sep_left}%{F${color_icon} B${local_ip_cback}} %{T2}${net_icon}%{F- T1} ${net_arr_ip}"

            ## Wifi Signal Strength
            if [ "${net_arr_signal}" != "none" ]; then
                wifi="%{F${color_icon}}${sep_l_left}%{F${color_icon} B${local_ip_cback}} %{T2}${icon_wifi}%{F- T1} ${net_arr_signal}%"
              else
                wifi=""
            fi

            ## External IP clean up
            ## This stops an external IP from displaying, if on local IP.
            ## This is in this section, as it run much much more often.
            if [ "${net_arr_ip}" = "No IP" ]; then
                ext_ip="%{F${ext_ip_cback}}${sep_left}%{F${color_icon} B${ext_it_cback}} %{T2}${icon_ext_ip}%{F- T1} No IP"
            fi

            ## External IP icon to VPN icon
            ## This will swap the normal icon to show that a VPN is up.
            ## This is in this section, as it run much much more often.
            if [ "${net_arr_vpn}" = "VPN" ]; then
                vpn="%{F${color_icon}}${sep_l_left}%{B${ext_ip_cback}}%{F${color_icon} B${ext_ip_cback}} %{T2}${icon_vpn}"
              else
                vpn=""
            fi
            ;;
        ### End Network Case ### }}}

        ### External IP Case ### {{{
        EXT*)
            ## External IP
            ext_arr="${line#???}"
            if [ "${net_arr_ip}" = "${ext_arr}" ]; then
                ext_ip_select="Same"
              else
                ext_ip_select="${ext_arr}"
            fi
            ext_ip="%{F${ext_ip_cback}}${sep_left}%{F${color_icon} B${ext_ip_cback}} %{T2}${icon_ext_ip}%{F- T1} ${ext_ip_select}"
            ;;
        ### End External IP Case ### }}}

        ### Volume Case ### {{{
        VOL*)
            ## Display Volume
            vol_arr="${line#???}"
            vol="%{F${vol_cback}}${sep_left}%{F${color_icon} B${vol_cback}} %{T2}${icon_vol}%{F- T1} ${vol_arr}"
            ;;
        ### End Volume Case ### }}}

        ### Brightness Case ### {{{
        BRI*)
            ## Display Brightness
            bright_arr="${line#???}"

            ## Don't show brightness if there is no battery.
            ## Most desktops don't software adjust brightness.
            ## I suppose there is a small use case of a laptop with no battery...
            if [ "${bright_arr}" != "none" ]; then
                bri="%{F${color_icon}}${sep_l_left}%{F${color_icon} B${color_sec_b2}} %{T2}${icon_bri}%{F- T1} ${bright_arr}%"
              else
                bri=""
            fi
            ;;
        ### End Brightness Case ### }}}

        ### Temperature Case ### {{{
        TMP*)
            ## Display Temperature
            read -r -a temp_arr <<< "${line#???}"
            temp_arr_val="${temp_arr[0]}"
            temp_arr_unit="${temp_arr[1]}"

            if [ "${temp_arr_val}" != "none" ]; then
                ## Select alert for measurement system
                if [ "${temp_arr_unit}" == "C" ]; then
                    temp_check=$(awk -v x=${temp_arr_val} -v y=${temp_alert_c} 'BEGIN {if (x<y){print 0} else {print 1}}')
                  else
                    temp_check=$(awk -v x=${temp_arr_val} -v y=${temp_alert_f} 'BEGIN {if (x<y){print 0} else {print 1}}')
                fi

                ## Set alert color
                if [ ${temp_check} -eq 1 ]; then
                    temp_set_back=${color_temp}; temp_cicon=${color_back}; temp_cfore=${color_back};
                  else
                    temp_set_back=${temp_cback}; temp_cicon=${color_icon}; temp_cfore=${color_fore};
                fi
                temp="%{F${temp_set_back}}${sep_left}%{F${temp_cicon} B${temp_set_back}} %{T2}${icon_temp}%{F${temp_cfore} T1} ${temp_arr_val}${temp_arr_unit}"
              else
                ## Set if temp fifo missing
                temp="%{F${temp_cback}}${sep_left}%{F${color_disable} B${temp_cback}} %{T2}${icon_temp}%{F${color_disable} T1} ×"
            fi
            ;;
        ### End Temperature Case ### }}}

        ### Offlineimap Case ### {{{
        EMA*)
            ## Display unreal mail (offlineimap)
            email_arr="${line#???}"
            if [ "${email_arr}" != "0" ]; then
                mail_set_back=${color_mail}; mail_cicon=${color_sec_b2}; mail_cfore=${color_sec_b2}; mail_icon=${icon_mail}; mail_num=${email_arr}; mail_post_sep=${sep_left}
              else
                mail_set_back=${mail_cback}; mail_cicon=${color_icon}; mail_cfore=${color_fore}; mail_icon=${icon_mail_read}; mail_num=""; mail_post_sep=${sep_l_left}
            fi
            email="%{F${mail_set_back}}${sep_left}%{F${mail_cicon} B${mail_set_back}} %{T2}${mail_icon}%{F${mail_cfore} T1} ${mail_num}"
            ;;
        ### End Offlineimp Case ### }}}

        ### GPG Case ### {{{
        GPG*)
            ## Display if gpg keys are unlocked in cache
            gpg_arr=(${line#???})
            if [ "${gpg_arr}" != "none" ]; then
                if [ "${gpg_arr}" = "1" ]; then
                    lock="${icon_gpg_unlocked}"
                  else
                    lock="${icon_gpg_locked}"
                fi

                gpg="%{F${gpg_cback}}${sep_left}%{F${color_icon} B${gpg_cback}} %{T2}${icon_gpg}%{F${color_fore} T1} ${lock}"
            fi
            ;;
        ### End GPG Case ### }}}

        ### RSS Case ### {{{
        RSS*)
            ## Display newsboat unread count
            rss_arr=(${line#???})
            if [ -n "${rss_arr}" ]; then
                rss="%{F${rss_cback}}${sep_left}%{F${color_icon} B${rss_cback}} %{T2}${icon_rss}%{F${color_fore} T1} ${rss_arr}"
            fi
            ;;
        ### End RSS Case ### }}}

        ### Thinkpad Multi Battery ### {{{
        ## Icon         0         1         2         3          4
        ## Bat >=      NA        11        37        63         90
        ## Range     0-10     11-36     37-62     63-89     90-100

        TMB*)
            ## Now that I have >12 hours of battery, I don't feel the need for as drastic color thresholds.
            ## I will have colors only at much lower percentages.

            read -r -a tmb_arr <<< "${line#???}"
            tmb_arr_perc="${tmb_arr[0]}"
            tmb_arr_stat="${tmb_arr[1]}"
            tmb_arr_time="${tmb_arr[2]}"

            ## This means it will not show up on desktop computers
            if [ "${tmb_arr_perc}" != "none" ]; then
                ## Set icon only
                ## This is 'hard' coded, instead of in the conf, due to icon font.
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
                    bat_cicon=${color_icon}; bat_cfore=${color_fore}; bat_set_back=${color_bat_low};
                elif [ ${tmb_arr_perc} -le ${bat_alert_mid} ]; then
                    bat_cicon=${color_icon}; bat_cfore=${color_fore}; bat_set_back=${color_bat_mid};
                elif [ ${tmb_arr_perc} -le ${bat_alert_high} ]; then
                    bat_cicon=${color_bat_high}; bat_cfore=${color_fore}; bat_set_back=${bat_cback};
                  else
                    bat_cicon=${color_icon}; bat_cfore=${color_fore}; bat_set_back=${bat_cback};
                fi

                ## Set charging icon
                if [ "${tmb_arr_stat}" == "C" ]; then
                    bat_icon=${icon_bat_plug}; bat_cicon=${color_bat_plug};
                fi
                bat="%{F${bat_set_back}}${sep_left}%{F${bat_cicon} B${bat_set_back}} %{T2}${bat_icon}%{F- T1} ${tmb_arr_perc}%"

                if [ "${tmb_arr_time}" != "none" ]; then
                    bat_time="%{F${color_icon}}${sep_l_left}%{F${color_icon} B${bat_cback}} %{T2}${icon_bat_time}%{F- T1} ${tmb_arr_time}"
                  else
                    bat_time=""
                fi
              else
                ## If a desktop, show a plug icon. This stops the ugly segment merge that that would happen.
                bat="%{F${bat_cback}}${sep_left}%{F${color_icon} B${bat_cback}} %{T2}${icon_bat_plug}%{F- T1}"
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

        ### Mutli Music Player Display ### {{{
        MMP*)
            ## Display Music Status
            mmpd_arr="${line#???}"
            if [ -z "${mmpd_arr}" ] || [ "${mmpd_arr}" == "none" ]; then
                ## This can deal with odd issues?
                mmpd_song="×";
              else
                ## $music_limit will help stop the music from taking over the workspace display on the left.
                ## Note: you should read http://tldp.org/LDP/abs/html/parameter-substitution.html
                mmpd_song="${mmpd_arr:0:${music_limit}}";
            fi
            mmpd="%{F${mmpd_alt_cback}}${sep_left}%{B${mmpd_alt_cback}}%{F${mmpd_cback}}${sep_left}%{F${color_icon} B${mmpd_cback}} %{T2}${icon_music}%{F${color_fore} T1} ${mmpd_song}"
            ;;
        ### End Multi Music Player Display ### }}}

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
            ## Display window title
            title=$(xprop -id ${line#???} | awk '/_NET_WM_NAME/{$1=$2="";print}' | cut -d'"' -f2)
            title="%{F${color_head} B${color_sec_b2}}${sep_right}%{F${color_head} B${color_sec_b2} T2} ${icon_prog} %{F${color_sec_b2} B-}${sep_right}%{F- B- T1} ${title}"
            ;;
        ### End Window Case ### }}}
    esac

    ### Network Display Toggle ### {{{
    # This is toggled by, preferably, a binding in your ~/.i3/config
    ## You can find the awk command in my config, or this bar's readme

    extip_toggle="$(cat /tmp/i3_lemonbar_ip_${USER} 2>/dev/null)"

    if [ "${extip_toggle}" = 2 ]; then
        local_ip="%{F${local_ip_cback}}${sep_left}%{F${color_icon} B${local_ip_cback}} %{T2}${net_icon}%{F- T1} ${scrub_ip}"
        filler="%{F${ext_ip_cback}}${sep_left}%{F${color_icon} B${ext_ip_cback}} %{T2}${icon_ext_ip}%{F- T1}"
        mast_net="${local_ip}${stab}${wifi}${stab}${filler}${stab}${vpn}${stab}"
      elif [ "${extip_toggle}" = 1 ]; then
        if [ "${net_arr_ipv6}" = "none" ]; then
            net_arr_ipv6="No IPv6"
        fi

        filler="%{F${local_ip_cback}}${sep_left}%{F${color_icon} B${local_ip_cback}} %{T2}${net_icon}%{F- T1}"
        ipv6_ip="%{F${ext_ip_cback}}${sep_left}%{F${color_icon} B${ext_ip_cback}} %{T2}${icon_ext_ip}%{F- T1} ${net_arr_ipv6}"
        mast_net="${filler}${stab}${ipv6_ip}"
      else
        mast_net="${local_ip}${stab}${wifi}${stab}${ext_ip}${stab}${vpn}${stab}"
    fi
    ### End Network Display Toggle ### }}}

    ## And finally, output
    ## Broken into multiple lines to make more readable.
    ## You can rearrange them or remove them as desired.
    ## Notice that all but the first and last have a ${stab} for spacing.

    ## NOTE: At this moment, there is not a dead simple way to adjust a
    # segment between the three background colors, you have to manually
    # find the CASE and edit.

    ## NOTE: Now with multi monitor support **18JUN2019**
    # source https://github.com/electro7/dot_debian/pull/24

    ## Declare bar layout
    bar="$(printf "%s\n" "%{l}${wsp}${title} %{r}\
${mmpd}${stab}\
${rss}${stab}\
${email}${stab}\
${gpg}${stab}\
${mast_net}${stab}\
${bat}${stab}\
${bat_time}${stab}\
${cpu}${stab}\
${mem}${stab}\
${diskr}${stab}\
${temp}${stab}\
${nets_d}${stab}\
${nets_u}${stab}\
${vol}${stab}\
${bri}${stab}\
${date}${stab}\
${time}")"

    ## Do multi monitor magic
    out=""
    mcount="$(xrandr --listactivemonitors | head -1 | awk '{print $2}')"
    for i in $(seq 0 $((mcount -1))); do
        out+="%{S$i}$bar"
    done
    echo "$out"

done
