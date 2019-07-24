##Oneliners
This will be a file listing a number of the fancy 'oneliners' I make use of (and made).


###Powersaver toggle
This is a little awk to toggle between having the screen power saving on/off.  
Helps keep music going through my external speakers when docked.

```
xset q | awk 'BEGIN {C="xset -display :0.0"} /DPMS is/ {match($0,/DPMS is (.*)/,m)} END {if(m[1]=="Enabled"){D="-dpms";S="off";B="noblank"} else {D="dpms";S="on";B="blank"}} END {system(C" "D);system(C" s "S);system(C" s "B)}'
```


###lemonbar restart
Simplifies restarting my fancy lemonbar.  
Useful when going between single/multiple monitors.

```
pkill lemonbar; $HOME/.i3/lemonbar/i3_lemonbar.sh &
```


###Lemonbar ipv6/external ip toggle
A little trinary switch for toggling between "ipv4+external ipv4", "ipv6", and "hide ip" modes in my lemonbar


```
awk -v TEMP=/tmp/i3_lemonbar_ip_${USER} 'BEGIN {{FILE=getline < TEMP < 0 ? "0" : "1"} {if($0==1){STATE=1} else if($0==2){STATE=2} else{STATE=0}} {if(STATE==0){system("echo 1 > "TEMP)} else if(STATE==1){system("echo 2 > "TEMP)} else {system("echo 0 > "TEMP)}} }'
```


###xss-lock toggle
This kills xss-lock, or starts it

```
pkill xss-lock || xss-lock -- i3block -e -c 2E3436 &
```


###Volume check that can show >100% settings

```
pactl list sinks | awk 'BEGIN {MUTE="none";VOL="none"}/^\t*Volume|^\t*Mute/ {if($1=="Mute:"){MUTE=$2};if($1=="Volume:"){VOL=$5}} END {if(MUTE=="yes"){print "VOL×\n"} else {if(VOL!="none"){printf "VOL%d%%\n", VOL} else {print "VOLerror\n"};}}'
```


###Brightness check

```
paste /sys/class/backlight/*/{actual_brightness,max_brightness} | awk '{BRIGHT=$1/$2*100} END {if(BRIGHT!=0){printf "%.f", BRIGHT} else {print "none"}}'
```


###Temp check

```
acpi -t${temp_format} 2>/dev/null | awk 'BEGIN {} /Thermal 0/ {if($6=="C"){printf "%.0f %s",$4,$6} else {if($6=="F"){print $4,$6} else {print "none none"};}}'
```


###Memory free check

```
awk '/MemAvailable/ {AVAIL=$2} /MemTotal/ {TOTAL=$2} END {printf "%.0f%\n", (1-AVAIL/TOTAL)*100}' /proc/meminfo
```


###newboat unread check

```
sqlite3 ${rss_path} 'select sum(unread) from rss_item'
```
