#!/bin/sh
##### My (demuredemeanor) .xinitrc
# Uses shiftwidth=4 for tabs; foldmarker={{{,}}} for folds;
# https://notabug.org/demure/dotfiles/
# legacy repo http://github.com/demure/dotfiles

## Fix my sound? damn pusle per user
#pulseaudio --start

## Fix path for WM?
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/pkg/bin:/usr/local/bin:/usr/local/sbin:${HOME}/projects/personal/scripts:${HOME}/bin:${HOME}/.local/bin:/usr/local/games:/usr/games


## Call WM
# dont forget about $(xinit /usr/local/bin/spectrwm -- :1 &) for testing
## I don't think consolekit does anything helpful for me? and wastes a ton of mem.
#exec ck-launch-session dbus-launch --sh-syntax --exit-with-session /usr/bin/i3
exec /usr/bin/i3

