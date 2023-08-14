#!/bin/bash


WKCERTBOT_SCRIPT_LOCATION=${WKCERTBOT_SCRIPT_LOCATION-"https://raw.githubusercontent.com/wisekeylab/wkcertbot/master/get-wkcertbot.sh"}

function install_wkcertbot()
{
    curl -s "$WKCERTBOT_SCRIPT_LOCATION" > /tmp/wkcertbot
    sudo bash <<EOF
        mkdir -p /usr/local/bin && \
        mv /tmp/wkcertbot /usr/local/bin/wkcertbot && \
        chmod +x /usr/local/bin/wkcertbot
EOF
}

install_wkcertbot
