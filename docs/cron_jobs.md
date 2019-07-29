<!--
##### My (demuredemeanor) list of cron jobs
# vim: set expandtab ts=4 sw=4: ## Since this is markdown
# https://notabug.org/demure/dotfiles/
# legacy repo http://github.com/demure/dotfiles
-->


## My Cron Jobs ##
This file helps keep track of my various cronjobs.


### Reference ###
```
# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name command to be executed
```


### Main ###
#### User `crontab -e` ###
```
## Clean up vim backups/undos that are haven't been modified in over 60 days
0 */12 * * * find $HOME/.vim/back/ $HOME/.vim/undo/ -maxdepth 1 -type f -mtime +60 -delete

## borgbackup wrapper
0 */1 * * * sudo /usr/local/sbin/borg_wrap.sh -q

## Update calendars for khal
0 */12 * * * /usr/bin/vdirsyncer sync &>/dev/null

```


### Laptop ###
#### User `crontab -e` ###
```
## Run reverse ssh script
*/10 * * * * $HOME/projects/personal/scripts/cron_key.sh "$HOME/projects/personal/scripts/reverse_ssh.sh"

## Clean up pianobar album art dir
0 */6 * * * find $HOME/.config/pianobar/albumart/ -maxdepth 1 -type f -mtime +60 -delete
```


### VPS ###
#### User `crontab -e` ###
```
## Copy irpg data to idle rpg website
0 */1 * * * cp /irpg/quest.txt /irpg/modifiers.txt /irpg/irpg.db /var/www/irpg/data/

## Make sure irpg is up
* */2 * * * /irpg/irpg_wrapper.sh

## Make sure there is a tunnel to sdf's ircd
## NOTE: not currently needed due to oline vhost.
#*/10 * * * * $HOME/projects/personal/scripts/cron_key.sh "$HOME/projects/personal/scripts/sdf_tun_ssh.sh"

## Update pit.demu.red
0 */2 * * * $HOME/projects/personal/scripts/endlessh_scoreboard.py

## Start syncthing
## NOTE: laptop starts via i3
@reboot /usr/bin/syncthing -no-browser
```


#### ircd user ####
```
## Start atheme
@reboot $HOME/atheme/bin/atheme-services
## reload ssl
0 0 1 * * pkill -USR1 inspircd
```


#### System `/etc/crontab` ####
```
## This script is used to keep some privte IPs out of my dotfiles
@reboot             root    sleep 300 && /usr/local/sbin/f2b_ignore_ip.sh add IP1 IP2 IP3...

## Start gopher server on boot
@reboot             root    /usr/bin/geomyidae -l /var/log/geomyidae -u gopher -g gopher -h demu.red

## Start endlessh on boot
@reboot             root    /usr/local/sbin/endlessh -p 22 -v >/var/log/endlessh.log 2>/var/log/endlessh.err

## Keeps inspircd ssl up to date
0   */6 *   *   *   root    /bin/cp /etc/letsencrypt/live/demu.red/*.pem ~inspircd/inspircd/run/conf/le-ssl/¬
1   */6 *   *   *   root    /bin/chown inspircd:inspircd ~inspircd/inspircd/rung/conf/le-ssl/*¬

## Weechat relay stuff
0   */6 *   *   *   root    /bin/cat /etc/letsencrypt/live/demu.red/privkey.pem /etc/letsencrypt/live/demu.red/fullchain.pem > ~demure/.weechat/ssl/le_relay.pem

## Restart nginx montly to ensure cert is up to date.
0   0   1   *   *   root    /usr/sbin/service nginx restart
```
