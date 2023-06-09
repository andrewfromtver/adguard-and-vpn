# how to

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
* `PROMETHEUS_IP=10.5.0.101`
* `GRAFANA_IP=10.5.0.102`

*Grafana creds*
* `GF_SECURITY_ADMIN_USER=admin`
* `GF_SECURITY_ADMIN_PASSWORD=qwerty12`

# .creds params

*AdGuard creds*
* `ADGUARD_USERNAME=admin`
* `ADGUARD_PASSWORD_HASH=<password_hash_check_AdGuard_docs>`

*Prometheus creds*
* `PROMETHEUS_USERNAME=admin`
* `PROMETHEUS_PASSWORD_HASH=<password_hash_check_Node-exporter_docs>`
* `PROMETHEUS_PASSWD=qwerty12`

*Nginx creds*
* `NGINX_USERNAME=admin`
* `NGINX_PASSWORD_HASH=<password_hash_check_Nginx_docs>`

# http pages

*AdGuard web UI*
`http://{GLOBAL_VPN_ADDRESS}`

*Open VPN config download page*
`http://{GLOBAL_VPN_ADDRESS}/get-vpn`

*Grafana web UI*
`http://{GLOBAL_VPN_ADDRESS}:3000`

*Prometheus Node-exporter metrics*
`http://{GLOBAL_VPN_ADDRESS}:9100/metrics`

# screenshots

![Screenshot_01](docs/Screenshot-01.png)

![Screenshot_02](docs/Screenshot-02.png)

![Screenshot_02](docs/Screenshot-03.png)
