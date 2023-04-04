# how to:

* Add `.env` & `.creds` files (in `./` folder)
* Execute deploy script`./deploy.sh`

# .env params

*Global IpV4 settings*
* `GLOBAL_VPN_ADDRESS=xxx.xxx.xxx.xxx`
* `GLOBAL_VPN_PORT=5001`

*Local IpV4 settings*
* `LOCAL_SUBNET=10.5.0.0/24`
* `LOCAL_GATEWAY=10.5.0.1`
* `LOCAL_NGINX_IP=10.5.0.3`
* `LOCAL_VPN_IP=10.5.0.10`
* `ADGUARD_DNS_IP=10.5.0.2`
* `OPENVPN_SERVER_SUBNET=10.8.0.0 255.255.255.0`

# .creds params

*AdGuard creds*
* `ADGUARD_USERNAME=admin`
* `ADGUARD_PASSWORD_HASH=<password_hash_check_AdGuard_docs>`

*NGINX creds*
* `NGINX_USERNAME=admin`
* `NGINX_PASSWORD_HASH=<password_hash_check_NGINX_docs>`
