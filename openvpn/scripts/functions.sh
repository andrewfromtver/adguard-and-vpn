#!/bin/bash

function datef() {
    date "+%a %b %-d %T %Y"
}

function createConfig() {
    cd "$APP_PERSIST_DIR"
    CLIENT_ID="$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)"
    CLIENT_PATH="$APP_PERSIST_DIR/clients/$CLIENT_ID"

    easyrsa build-client-full "$CLIENT_ID" nopass &> /dev/null

    mkdir -p $CLIENT_PATH

    cp "pki/private/$CLIENT_ID.key" "pki/issued/$CLIENT_ID.crt" pki/ca.crt /etc/openvpn/ta.key $CLIENT_PATH

    cd "$APP_INSTALL_PATH"
    cp config/client.ovpn $CLIENT_PATH

    echo -e "\nremote $HOST_ADDR $HOST_TUN_PORT" >> "$CLIENT_PATH/client.ovpn"

    cat <(echo -e '<ca>') \
        "$CLIENT_PATH/ca.crt" <(echo -e '</ca>\n<cert>') \
        "$CLIENT_PATH/$CLIENT_ID.crt" <(echo -e '</cert>\n<key>') \
        "$CLIENT_PATH/$CLIENT_ID.key" <(echo -e '</key>\n<tls-auth>') \
        "$CLIENT_PATH/ta.key" <(echo -e '</tls-auth>') \
        >> "$CLIENT_PATH/client.ovpn"

    echo ";client-id $CLIENT_ID" >> "$CLIENT_PATH/client.ovpn"

    echo $CLIENT_PATH
}

function zipFiles() {
    CLIENT_PATH="$1"
    IS_QUITE="$2"

    zip -q -j "$CLIENT_PATH/client.zip" "$CLIENT_PATH/client.ovpn"
    if [ "$IS_QUITE" != "-q" ]
    then
       echo "$(datef) $CLIENT_PATH/client.zip file has been generated"
    fi
}

function zipFilesWithPassword() {
    CLIENT_PATH="$1"
    ZIP_PASSWORD="$2"
    IS_QUITE="$3"

    zip -q -j -P "$ZIP_PASSWORD" "$CLIENT_PATH/client.zip" "$CLIENT_PATH/client.ovpn"

    if [ "$IS_QUITE" != "-q" ]
    then
       echo "$(datef) $CLIENT_PATH/client.zip with password protection has been generated"
    fi
}
