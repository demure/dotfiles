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

## auto lock
xss-lock -- i3lock -c 2E3436 &

## Uses spectrwm instead of distasteful gnome 3 :p
#exec ck-launch-session dbus-launch /usr/local/bin/spectrwm

## git install
# dont forget about $(xinit /usr/local/bin/spectrwm -- :1 &) for testing
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session /usr/local/bin/spectrwm

## system install
#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session /usr/bin/spectrwm
