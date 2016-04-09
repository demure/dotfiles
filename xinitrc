#!/bin/sh
##### My (demuredemeanor) .xinitrc
# Uses shiftwidth=4 for tabs; foldmarker={{{,}}} for folds;
# https://notabug.org/demure/dotfiles/
# legacy repo http://github.com/demure/dotfiles

## Fix my sound? damn pusle per user
#pulseaudio --start

## Uses spectrwm instead of distasteful gnome 3 :p
#exec ck-launch-session dbus-launch /usr/local/bin/spectrwm

## git install
# dont forget about $(xinit /usr/local/bin/spectrwm -- :1 &) for testing
## I don't think consolekit does anything helpful for me? and wastes a ton of mem.
#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session /usr/bin/i3
exec /usr/bin/i3

