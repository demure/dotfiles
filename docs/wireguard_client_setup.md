## Notes on wireguard client setup
Some notes for the next time I add a host to my wireguard


### Install
#### arch
```
yay wireguard
yay wireguard-tools
```


#### debian
```
apt install -y wireguard wireguard-tools
```


### Generate the new keys
```
cd /etc/wireguard
umask 0077
wg genkey > private.key
wg pubkey < private.key > public.key
```


### Edit the remote and local
Ensure each config has its private key, and the other's public

```
cat /etc/wireguard/private.key >> /etc/wireguard/wg0.conf
vim /etc/wireguard/wg0.conf
```

#### Client Config Contents
```
[Interface]
Address = 99.0.99.X/24
PrivateKey = CLIENT_PRIVATE_STRING_HERE

[Peer]
PublicKey = SERVER_PUBLIC_STRING_HERE
##Set ACLs
AllowedIPs = 99.0.99.0/24
Endpoint = HOST_DOMAIN_HERE:51194
PersistentKeepalive = 20
```


#### Add to Server Config
```
[Peer]
## Name of thing here, so I know what it is later
PublicKey = CLIENT_PUBLIC_STRING_HERE
AllowedIPs = 99.0.99.X/32
```


### Manual test
After making changes to the server side config, you will need to restart wireguard there too.

```
wg-quick down wg0
wg-quick up wg0
ping IP_HERE
```


### When manually tested as good
```
systemctl enable wg-quick@wg0-service
systemctl start wg-quick@wg0-service
```
