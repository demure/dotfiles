## Setting up borg backups on a truenas scale with borgmatic

### 1: Add a borg user to NAS
Make a new user named borg
* disable smb access (this blocks disabling the passwd)
* disable passwd
* add ssh pub keys to auth keys
* set home (requires a pool)


### Get binary
https://github.com/borgbackup/borg/releases


### Setup borg user bin
Make a bin dir, `mkdir ~borg/bin`
untar borg tgz and move contents of borg-dir into ~/bin


### borgmatic config
`borgmatic config generate`
add a line about `remote_path: ~/bin/borg`


### Add borgmatic sudoers.d file
Make and edit `/etc/sudoers.d/borg_sudoers` to contain:

```
## Lets me and my cron script preform backups
your_user ALL=(ALL) NOPASSWD: /bin/borgmatic "", /bin/borgmatic create, /bin/borgmatic check, /bin/borgmatic list, /bin/borgmatic info, /bin/borgmatic --verbosity 1 --files
```

### crontab
Install cronie, run `crontab -e`, add:

```
## borgbackup wrapper
0 6,12,18 * * * sudo borgmatic create
0 0,22 * * * sudo borgmatic
```


### setup auth key file to limit vps
As the vps is the least in my control, limit what its borg ssh keys can do.
Edit the authorized to prepend this to the vps's key line:

```
command="~/bin/borg serve --restrict-to-path /mnt/main_pool/backups/vps-arch",no-pty,no-agent-forwarding,no-port-forwarding,no-X11-forwarding,no-user-rc KEY_HERE
```
