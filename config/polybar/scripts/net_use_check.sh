#!/bin/bash
## Forked from https://github.com/polybar/polybar-scripts/blob/master/polybar-scripts/network-traffic/network-traffic.sh


print_bytes() {
    if [ "$1" -eq 0 ] || [ "$1" -lt 1000 ]; then
        bytes=" 0"
      elif [ "$1" -lt 1000000 ]; then
        bytes="$(echo "scale=0;$1/1000" | bc -l)k"
      else
        bytes="$(echo "scale=1;$1/1000000" | bc -l)%{F${M_HI}}M"
    fi

    echo "$bytes"
}


## Variables
INTERVAL=2
## Space delimited list of interfaces: INTERFACES="eth0 wlan0"
INTERFACES="wlan0"

declare -A bytes


## Declare colors
M_FG="#C5C8C6"
M_FG_ICON="#979997"

M_HI="#F0C674"      ## byellow


for interface in ${INTERFACES}; do
    bytes[past_rx_${interface}]="$(cat /sys/class/net/"${interface}"/statistics/rx_bytes)"
    bytes[past_tx_${interface}]="$(cat /sys/class/net/"${interface}"/statistics/tx_bytes)"
done


while true; do
    down=0
    up=0

    for interface in ${INTERFACES}; do
        bytes[now_rx_${interface}]="$(cat /sys/class/net/"${interface}"/statistics/rx_bytes)"
        bytes[now_tx_${interface}]="$(cat /sys/class/net/"${interface}"/statistics/tx_bytes)"

        bytes_down=$((((${bytes[now_rx_${interface}]} - ${bytes[past_rx_${interface}]})) / INTERVAL))
        bytes_up=$((((${bytes[now_tx_${interface}]} - ${bytes[past_tx_${interface}]})) / INTERVAL))

        down=$(((( "${down}" + "${bytes_down}" ))))
        up=$(((( "${up}" + "${bytes_up}" ))))

        bytes[past_rx_${interface}]=${bytes[now_rx_${interface}]}
        bytes[past_tx_${interface}]=${bytes[now_tx_${interface}]}
    done

    ## Return results
    echo "%{F${M_FG_ICON}}%{O2}%{O2}%{F${M_FG}}$(print_bytes ${down})%{F${M_FG_ICON}}%{O2}%{O2}%{O2}%{F${M_FG}}$(print_bytes ${up})%{O2}"

    ## Delay next run
    sleep ${INTERVAL}
done
