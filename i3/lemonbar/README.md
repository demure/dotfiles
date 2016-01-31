##Demure's i3 lemonbar

###Base
This is based off of [i3 lemonbar].
While a lot of the code is the same, I have modified it to do what I want.
There were a few parts of the original that didn't make sense to me, and other things I wanted to add.

###Requirements
This requires `lemonbar` (which used to be called `bar`).
I *not* recommend the vanila lemonbar, as it's xft font support is... crap?
I use [lemonbar krypt-n] instead of [lemonbar].

This will also need [i3wm], as it is tailored for this.

###Modifications
* On my system, volume and a number of other segments had an extra `%`. **FIXED**
* Edited vol command to be more efficient, and not need a conf line **FIXED**
* I felt that the declaring 1024 as a 'small screen' was falling short, set to 1336. **FIXED**
* Edited the buffer between segments to be smaller. **FIXED**
* Removed gmail support, and added offlineimap support **FIXED**
* Added local ip, prefers eth over wlan; shows appropriate icon; shows wifi signal strength if wifi. **FIXED**
* Added external ip **FIXED**
* Added battery, different icons for level, different colors for level, icon for charging. **FIXED**
* Added temp, with threshold color. **FIXED**
* Made ram show percent instead of raw number **FIXED**
* Disabled weechat part, as my weechat lives on my server. Work need a major overhaul, and likely be out of sync, or insecure.
* Made one segment for both eth and wlan speed, prefers eth. **FIXED**

###Things I want
* I am not sure if I can make this set up show i3 keybinding modes in the bar... would like this.


[i3 lemonbar]: https://github.com/electro7/dotfiles/tree/master/.i3/lemonbar
[lemonbar krypt-n]: https://github.com/krypt-n/bar
[lemonbar]: https://github.com/LemonBoy/bar
[i3wm]: https://i3wm.org
