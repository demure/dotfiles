##Demure's i3 lemonbar

![my bar][pic0]

###Base
This is based off of [i3 lemonbar], by electro7.
While a lot of the code is the same, I have modified it to do what I want.
There were a few parts of the original that didn't make sense to me, and other things I wanted to add.


###Requirements
* [i3wm]
* `lemonbar` (which used to be know as `bar`)
  * I use [lemonbar krypt-n] instead of [lemonbar].
   * I do *not* recommend the vanila lemonbar, as it's xft font support is... crap?
* You need [conky]
  * on debian sid, I use the `conky-all` package
  * on arch, make sure the wireless support compiled in
* A nice symbol font
  * I use font awesome, which is the best symbol font I have seen to date.


###Installation
* Install font awesome
  * or you can change the icon font, and set all the icons.
* You will need to check that the conky conf uses your hardware identifiers.
  * battery
  * wifi
  * ethernet
  * temp
* You may need to tweak the acpi paths in the main script for your system
  * brightness
  * thinkpad multi battery? (I think that this might be same across thinkpads though)


###Notes
* I find that this does not gracefully handle i3 logout -> login
  * I used `pkill lemonbar && ~/.i3/lemonbar/i3_lemonbar.sh &` to correct the issue


###Modifications
* On my system, volume and a number of other segments had an extra `%`. **FINISHED**
* Edited vol command to be more efficient, and not need a conf line **FINISHED**
* I felt that the declaring 1024 as a 'small screen' was falling short, set to 1336. **FINISHED**
* Edited the buffer between segments to be smaller. **FINISHED**
* Removed gmail support, and added offlineimap support **FINISHED**
* Added local ip, prefers eth over wlan; shows appropriate icon; shows wifi signal strength if wifi. **FINISHED**
* Added external ip **FINISHED**
* Added battery, different icons for level, different colors for level, icon for charging. **FINISHED**
* Added temp, with threshold color. **FINISHED**
* Made ram show percent instead of raw number **FINISHED**
* Disabled weechat part, as my weechat lives on my server. Work need a major overhaul, and likely be out of sync, or insecure.
* Made one segment for both eth and wlan speed, prefers eth. **FINISHED**
* <strike>Added control-pianobar for music, as I don't really use MPD. **27FEB2016**</stirke>
* Added check to see if gpg key is unlocked (since I use it for `pass`, which give `offlineimap` passwds) **19MAR2016**
* Added Thinkpad Multi Battery code. Will display ***weighted*** total battery percent. Other peoples code which I found only did `(bat0 perc + bat1 perc)/2`... Which is invalid, and extra invalid with an extended battery! There is a setting in the config to use either conky supplied battery, or the new Thinkpad Multi Battery. **09APR2016**
* Added Battery Time Remaining to Thinkpad Multi Battery. **17APR2016**
* Added Screen Brightness percent. **19JUN2016**
* Completely overhauled music code to how scalablely handle multiple music players. (requested by verrlara) **15JUL2016**
  * currently supports [control-pianobar] and [cmus].
    * cmus output will indicate paused and lack of meta data.


###Things I want
* I am not sure if I can make this set up show i3 keybinding modes in the bar... would like this.
* Make better separations between joined colored segments.


[i3 lemonbar]: https://github.com/electro7/dotfiles/tree/master/.i3/lemonbar
[lemonbar krypt-n]: https://github.com/krypt-n/bar
[lemonbar]: https://github.com/LemonBoy/bar
[i3wm]: https://i3wm.org
[conky]: https://github.com/brndnmtthws/conky
[pic]: https://notabug.org/demure/dotfiles/src/master/i3/lemonbar/demure_i3_lemonbar_mod.png
[pic0]: https://notabug.org/demure/dotfiles/raw/master/i3/lemonbar/demure_i3_lemonbar_mod.png
[control-pianobar]: https://malabarba.github.io/control-pianobar/
[cmus]: https://cmus.github.io/
