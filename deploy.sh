#!/bin/sh

clear

echo 'Clear RAM pagecache, dentries, and inodes ...'
echo ''

sync; echo 3 > /proc/sys/vm/drop_caches
free

echo ''
echo '########################################## Done ##########################################'
echo ''

echo 'Remove old version & build app cluster ...'
echo ''

ADGUARD_USERNAME=$(cat ./.creds | grep ADGUARD_USERNAME | cut -d "=" -f 2)
ADGUARD_PASSWORD_HASH=$(cat ./.creds | grep ADGUARD_PASSWORD_HASH | cut -d "=" -f 2)
NGINX_USERNAME=$(cat ./.creds | grep NGINX_USERNAME | cut -d "=" -f 2)
NGINX_PASSWORD_HASH=$(cat ./.creds | grep NGINX_PASSWORD_HASH | cut -d "=" -f 2)
ADGUARD_DNS_IP=$(cat ./.env | grep ADGUARD_DNS_IP | cut -d "=" -f 2)
OPENVPN_SERVER_SUBNET=$(cat ./.env | grep OPENVPN_SERVER_SUBNET | cut -d "=" -f 2)
GLOBAL_VPN_ADDRESS=$(cat ./.env | grep GLOBAL_VPN_ADDRESS | cut -d "=" -f 2)

mkdir -p ./.app_data/adguard/conf/
mkdir -p ./.app_data/custompasswd/
mkdir -p ./.app_data/openvpn/conf/

cp ./adguard/AdGuardHome.yaml ./.app_data/adguard/conf/AdGuardHome.yaml
cp ./nginx/.htpasswd ./.app_data/custompasswd/.htpasswd
cp ./openvpn/config/* ./.app_data/openvpn/conf/
cp ./monitoring/* ./.app_data/monitoring/

sed -i "s/ADGUARD_USERNAME/$ADGUARD_USERNAME/g" ./.app_data/adguard/conf/AdGuardHome.yaml
sed -i "s/ADGUARD_PASSWORD_HASH/$ADGUARD_PASSWORD_HASH/g" ./.app_data/adguard/conf/AdGuardHome.yaml

sed -i "s/NGINX_USERNAME/$NGINX_USERNAME/g" ./.app_data/custompasswd/.htpasswd
sed -i "s/NGINX_PASSWORD_HASH/$NGINX_PASSWORD_HASH/g" ./.app_data/custompasswd/.htpasswd

sed -i "s/ADGUARD_DNS_IP/$ADGUARD_DNS_IP/g" ./.app_data/openvpn/conf/server.conf
sed -i "s/OPENVPN_SERVER_SUBNET/$OPENVPN_SERVER_SUBNET/g" ./.app_data/openvpn/conf/server.conf

sed -i "s/GLOBAL_VPN_ADDRESS/$GLOBAL_VPN_ADDRESS/g" ./.app_data/monitoring/prometheus.yml

docker compose -p private-vpn down --remove-orphans
docker compose -p private-vpn build

echo ''
echo '########################################## Done ##########################################'
echo ''

echo 'Prepare project folders ...'
echo ''

mkdir -p ./.app_data
mkdir -p ./.app_data/vpn

touch ./.app_data/vpn/vpn-config.ovpn

ls -l ./.app_data

echo ''
echo '########################################## Done ##########################################'
echo ''

echo 'Start app cluster ...'

docker compose -p private-vpn up -d --wait private-vpn-nginx

echo ''
echo '########################################## Done ##########################################'
echo ''

echo 'Prepare VPN config file ...'
echo ''

docker exec -it open-vpn-node-1 wget localhost:8080
docker exec -it open-vpn-node-1 cat index.html > ./.app_data/vpn/vpn-config.ovpn
sed -i "/^client/a dhcp-option DNS $(cat ./.env | grep ADGUARD_DNS_IP | cut -d "=" -f 2)" ./.app_data/vpn/vpn-config.ovpn

echo ''
echo '########################################## Done ##########################################'
echo ''

echo ''
echo '##################################### Deploy summary #####################################'
echo ''

docker compose -p private-vpn ps

echo ''
echo '########################################## Done ##########################################'
echo ''
