#!/bin/sh
##### My (demuredemeanor) .xinitrc
# Uses shiftwidth=4 for tabs; foldmarker={{{,}}} for folds;
# https://notabug.org/demure/dotfiles/
# legacy repo http://github.com/demure/dotfiles

## So I have a background other than the one from update-alternitives
sh ~/.fehbg &

## Fix my sound? damn pusle per user
pulseaudio --start

## To make my keyboard better
usermodmap=$HOME/.Xmodmap
if [ -f $usermodmap ]; then
    /usr/bin/xmodmap $usermodmap
fi

## Makes lid close work, among other things
# still need to test this one
/usr/bin/xfce4-power-manager &

## Uses spectrwm instead of distasteful gnome 3 :p
#exec ck-launch-session dbus-launch /usr/local/bin/spectrwm
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session /usr/local/bin/spectrwm
