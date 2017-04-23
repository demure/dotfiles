## Demure's i3 lemonbar ##

![my bar][pic0]

### Base ###
This is based off of [i3 lemonbar], by electro7.
There were a few parts of the original that didn't make sense to me, and other things I wanted to add.
I've now added a number of features I have desired:

* Battery level works indicates no battery, normal %, and correct multiple battery %.
* Works with multiple music players, and has room to add more support.
* Works with my offlineimap setup.
* Shows either wired or wireless IP, using the same spot.
  * Indicates which is in use.
  * Prefers lower numbered interface (eth0 > wifi).
  * Filters virtual interfaces for docker, qemu, and vpn.
* Shows local IP+external IP, IPv6, or hide
  * You can bind an i3 key to toggle this display.
* Shows if a GPG key is cached, and hides of no GPG installed.
* Shows brightness and volume.
* Shows either wired or wireless Up/Down speed in the same spot.
* VPN indicator.


### Requirements ###
* [i3wm]
* `lemonbar` (which used to be know as `bar`)
  * I use [lemonbar krypt-n] instead of [lemonbar].
   * I do *not* recommend the vanila lemonbar, as it's xft font support is... crap?
   * On debian depends on `libxcb1-dev`, `libxcb-xinerama0-dev`, `xcb-randr0-dev`, `libxft-dev`, `libx11-xcb-dev` and a few other things (I listed the less common ones).
* `gawk`, as I wrote my fancy awk using it.
* `amixer` for volume support.
  * Part of `alsa-utils` on debian.
* You need [conky]
  * on debian sid, I use the `conky-all` package
  * on arch, make sure the wireless support compiled in. The AUR `conky-git` might be what you want.
* A nice symbol font
  * I use font awesome, which is the best symbol font I have seen to date.


### Installation ###
* Install font awesome
  * or you can change the icon font, and set all the icons.
* Add i3 lemonbar to your `~/.i3/config`

```
bar {
    i3_bar_command ~/.i3/lemonbar/i3_lemonbar.sh
    }
```


### **Notes** ###
* I find that this does not gracefully handle i3 logout -> login, and full config reload.
  * I used `pkill lemonbar && ~/.i3/lemonbar/i3_lemonbar.sh &` to correct the issue
  * I have added `pkill lemonbar` to my log out command and i3 restart, to make life easier.


### **Modifications** ###
* On my system, volume and a number of other segments had an extra `%`. **FINISHED**
* Edited vol command to be more efficient, and not need a conf line **FINISHED**
* I felt that the declaring 1024 as a 'small screen' was falling short, set to 1336. **FINISHED**
* Edited the buffer between segments to be smaller. **FINISHED**
* Removed gmail support, and added offlineimap support **FINISHED**
* Added local ip, <strike>prefers eth over wlan</strike>; shows appropriate icon; shows wifi signal strength if wifi. **FINISHED**
  * No longer uses conky, but will default to last outputted interface. **31JUL2016**
* Added external ip **FINISHED**
* Added battery, different icons for level, different colors for level, icon for charging. **FINISHED**
* Added temp, with threshold color. **FINISHED**
  * Made temp no longer rely on conky. **27JUL2016**
  * You can set temp to use ferinheight or celsius in the config.
* Made ram show percent instead of raw number **FINISHED**
* Disabled weechat part, as my weechat lives on my server. Work need a major overhaul, and likely be out of sync, or insecure.
* Made one segment for both eth and wlan speed, prefers eth. **FINISHED**
* <strike>Added control-pianobar for music, as I don't really use MPD. **27FEB2016**</strike>
* Added check to see if gpg key is unlocked (since I use it for `pass`, which give `offlineimap` passwds) **19MAR2016**
  * GPG icon will only show if GPG is installed (and maybe if there are keys?) **28JUL2016**
* Added Thinkpad Multi Battery code. Will display ***weighted*** total battery percent. Other peoples code which I found only did `(bat0 perc + bat1 perc)/2`... Which is invalid, and extra invalid with an extended battery! <strike>There is a setting in the config to use either conky supplied battery, or the new Thinkpad Multi Battery.</strike> **09APR2016**
  * Now made TMB detect no battery (desktop), normal batter, or thinkpad multi battery automagically. (as long as your computer uses BAT0 and/or BAT1) **27JUL2016**
  * Battery time remaining only shows when there is meaningful output.
    * Note: It will show either time till empty, or time till full. BUT, it only accounts for one battery... but still a bit useful to thinkpad users. **28JUL2016**
* Added Battery Time Remaining to Thinkpad Multi Battery. **17APR2016**
* Added Screen Brightness percent. **19JUN2016**
  * Tweaked brightness to automagically work with more installs. Made brightness hide for desktop (no battery) computers **31JUL2016**
* Completely overhauled music code to how scalablely handle multiple music players. (requested by verrlara) **14JUL2016**
  * currently supports [control-pianobar], [cmus], [mpd]<sup>(new code)</sup>, [mocp], and [audacious].
    * `cmus` output will indicate paused and lack of meta data.
    * `cmus` can display internet stream data too.
    * Readded `mpd` support with new awk. **15JUL2016**
    * `mpd` will report pause status, and works with internet streams even easier, as it didn't need extra coding.
    * `mocp` reports pause, and works with internet streams. **16JUL2016**
    * `audacious` reports paused, works with internet steams. **17JUL2016**
    * `audacious` has a default out put of 'Artist - Album - Song'; this can be changed in your audacious `Settings` -> `Playlist` -> `Title Format`
* <strike>Added Screenshot IP Scrubber, to quickly toggle the external IP from the bar. **18JUL2016**
  * You can add support to your i3 by adding the following binding:
  * `bindsym YOUR_KEYS exec awk -v TEMP=/tmp/i3_lemonbar_ip_${USER} 'BEGIN {{FILE=getline < TEMP < 0 ? "0" : "1"} {if($0==1){STATE=1} else {STATE=0}} {if(STATE==0){system("echo 1 > "TEMP)} else {system("echo 0 > "TEMP)}}}'`
  * You can edit the Scrubber sting in `i3_lemonbar_config`, such as setting it to `""` if you want to reduce your bar length when toggled.</strike>
* Added `$music_limit` to prevent music from covering workspace display. **18JUL2016**
* Fixed non conky network ip to prefer lower network interface. **22SEP2016**
* Network Display Toggle (replaces "Screenshot IP Scrubber"). **19FEB2017**
  * This lets you toggle between showing your local+external ipv4, your ipv6, or hiding.
  * can bind this in i3 with the following binding:
    * `bindsym XF86LaunchA exec awk -v TEMP=/tmp/i3_lemonbar_ip_${USER} 'BEGIN {{FILE=getline < TEMP < 0 ? "0" : "1"} {if($0==1){STATE=1} else if($0==2){STATE=2} else{STATE=0}} {if(STATE==0){system("echo 1 > "TEMP)} else if(STATE==1){system("echo 2 > "TEMP)} else {system("echo 0 > "TEMP)}}}'`
* IP display filters virtual interfaces for docker, qemu, and vpn. **08APR2017**
* Added VPN on indicator. **17APR2017**


### **Things I want** ###
* I am not sure if I can make this set up show i3 keybinding modes in the bar... would like this.
* Make better separations between joined colored segments.


##### **Last updated 23APR2017** #####

[i3 lemonbar]: https://github.com/electro7/dotfiles/tree/master/.i3/lemonbar
[lemonbar krypt-n]: https://github.com/krypt-n/bar
[lemonbar]: https://github.com/LemonBoy/bar
[i3wm]: https://i3wm.org
[conky]: https://github.com/brndnmtthws/conky
[pic]: https://notabug.org/demure/dotfiles/src/master/i3/lemonbar/demure_i3_lemonbar_mod.png
[pic0]: https://notabug.org/demure/dotfiles/raw/master/i3/lemonbar/demure_i3_lemonbar_mod.png
[control-pianobar]: https://malabarba.github.io/control-pianobar/
[cmus]: https://cmus.github.io/
[mpd]: https://www.musicpd.org/
[mocp]: https://moc.daper.net/
[audacious]: http://audacious-media-player.org/
