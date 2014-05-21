#!/bin/sh

sh ~/.fehbg &

usermodmap=$HOME/.Xmodmap
if [ -f $usermodmap ]; then
    /usr/bin/xmodmap $usermodmap
fi

xfce4-power-manager &

exec ck-launch-session dbus-launch /usr/local/bin/spectrwm
