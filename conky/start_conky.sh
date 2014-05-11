#!/bin/bash

sleep 6s &&
conky -d -c ~/.conky/dist-conky &

sleep 6s &&
conky -d -c /home/demure/.conky/flat-conky &

#sleep 6s &&
#conky -d -c $HOME/.conky/conkyrc_grey.lua &
## last conky line must not have a '&'
## Or not
exit
