#!/bin/bash
##### My (demuredemeanor) script for multiple conkys at the same time
# Uses tabstop=4; shiftwidth=4 tabs; foldmarker={{{,}}};
# https://tildegit.org/demure/dotfiles
# legacy https://notabug.org/demure/dotfiles
# legacy repo http://github.com/demure/dotfiles


sleep 6s &&
conky -d -c ~/.conky/dist-conky &

sleep 6s &&
conky -d -c /home/demure/.conky/flat-conky &

#sleep 6s &&
#conky -d -c $HOME/.conky/conkyrc_grey.lua &
## last conky line must not have a '&'
## Or not
exit
