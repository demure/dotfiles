#!/bin/bash

pkill -f "conky -qc"

#sleep 5
conky -qc ~/.config/i3/conky/back_log.conkyrc &
conky -qc ~/.config/i3/conky/back_backups.conkyrc &
conky -qc ~/.config/i3/conky/back_cal.conkyrc &
conky -qc ~/.config/i3/conky/back_task.conkyrc &

echo done
