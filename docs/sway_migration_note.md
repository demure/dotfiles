## TODO
* use nwg-displays to setup default monitors for workspaces?
* adjust on screen keyboard layout/profile?
* look into a cli command to invert screen colors in wayland
* flip display output horizontally binding
* comic reader that is better with touch screens than mcomix
* look into wayland middle click scrolling
* see if syslog-ng needs a cap for everything.log and others
* add more x86 key bindings
* sheepshaver internet?
* sheepshaver sound
* sixel use


## NOTES
* sway
  * titles were annoyingly large on gpd pocket 4
    * default_border pixel 2
  * Wanted to hop between last workspaces
    * bindsym $mod+Tab workspace back_and_forth
  * caps lock to escape
  * binding to move workspaces between monitors
  * fix touchpad (pointer) scroll dirrection
  * auto hide cursor
    * seat seat0 hide_cursor 3000

* firefox
  * disable passkeys
    * security.webauthn.enable_macos_passkeys
  * compact tabs
    * browser.compactmode.show
    * more tools, customize toolbar, density, compact
  * gfx.webrender.all
  * plugins
    * dark reader
    * ublock origin
    * vimium
  * disable search suggestions above history...
    * Show search suggestions ahead of browsing history in address bar results, uncheck
  * fullscreen videos into just the tile: full-screen-api.ignore-widgets
  * disable ai, browser.ml.enable false

* shikane setup

* ly setup
  * systemctl enable ly
  * vim /etc/ly/config.ini
  * systemctl restart ly
  * After a few weeks, gtk darkmode broke... Added `export GTK_THEME=Adwaita:dark` to `/etc/ly/wsetup.sh` 
    * ensure gnome-theme-extra is installed even though we dont gnome...

* warbar
  * fix hight
    * css
      * font size
      * min hight
  * power-profiles-daemon
  * pavucontrol
  * sway mode color
  * wvkbd

* fprintd
  * enable in pam for swaylock, and using swaylock-fprintdm, for lazy times
    auth sufficient pam_unix.so try_first_pass likeauth nullok
    auth sufficient pam_fprintd.so max-tries=3 timeout=10
  * https://gist.github.com/Mnkai/b755df1452c38eaf9af12636844e61da

* steam
  * wayland scaling makes thing ~1280x760 or whatever resolution
  * use gamescope
    * gamescope -W 1920 -H 1080 -w 2560 -h 1600 -r 144 -e -- steam -gamepadui

* sheepshaver
  * Error -- cannot map Low Memory Globals: Operation not permitted.
    * install extra/xorg-xhost
        * xhost +local:
        * SheepShaverGUI

* waydroid
  * waydroid init -s GAPPS
    * NOTE: it sounds like slow sourceforge download speeds is a known issue, and the suggested mitigation is to cancle and restart till you get a good mirror??

* maybe switching to foot terminal for sixel

* electron
  * install `qt5-wayland` to catch things not using `qt6-wayland`, such as `speedcrunch`

* cellular internet on GPD Pocket 4 with google fi data sim
  * install ModemMananer, usb_modeswitch
  * enable/start ModemManger with systemcl, restart NetworkManager for good measure
    * give things a few minutes to click
  * use `lsusb` to see wwan card
  * use `mmcli -L` to see that ModemManager sees card
  * use nm-applet gui to add a "Mobile Broadband" connection
    * Use "APN" of "h2g2"
    * Set "Connection Name" to "Google Fi"
    * save

* mount to /media
  * https://wiki.archlinux.org/title/Udisks#Mount_to_/media

* renameutils -> vimv
  * renameutils includes a imv, which conflicts with imv image viewer...
  * vimv does what I have been doing with `alias qm='qmv --format=destination-only'` by default

* dock with display link
  * install linux-headers
  * install displaylink drivers
  * enable/start displaylink service
  * reboot

* syslog-ng
  * https://wiki.archlinux.org/title/Syslog-ng#syslog-ng_and_systemd_journal

* mpv
  * mpv-mpris for playerctl

## new programs
* sway
* swaylock
* wofi to replace rofi -- rofi 2.0.0 added wayland support
* wofi-pass -- rofi 2.0.0 added wayland support
  * wtype
* wev
* wshowkeys
* grim
  * grimshot
* xdg-desktop-portal-wlr
* swayimg: rip feh
  * kind of meh?
* geeqie
* wl-sccreenrec
* nwg-displays
* shikane
* ly
* radeontop
* libva-utils
* wpaperd
  * wpaperctl
* wvkbd-mobintl
* cliphist
* pqiv
  * gvfs -- for url image handling
* gamescope
* bluetuith
* blueman
* pulseaudio-bluetooth
* lsix
* foliate
* ncspot
* modemmanager
  * usb_modeswitch
* vimv (rip renameutils)
* imv (pqiv is not 1:1 in wayland for me)
* displaylink
  * linux-headers
* exfatprogs (for exfat mounting)


## old programs
* bash-completion
* network-manager-applet
* syslog-ng
  * logrotate
* gucharmap
* sheepshaver
* epy
* qutebrowser


## References
* https://anarc.at/software/desktop/wayland/


