#!/bin/bash
###################################
# dyn-update-bind: 2012-11-27
# carlos@xt6.us
###################################

## config variables
ZONE=i.labs.lacnic.net
SERVER=mvuy.labs.lacnic.net
HOSTNAME=$(hostname)
TTL=60
## end config

get_ip_add() {

        if [ "$1" == "4" ]
        then
                ip -4 addr show dev $2 | awk '/inet/ {gsub("/","\t", $0); print $2}' 
        fi

        if [ "$1" == "6" ]
        then
                ip -6 addr show dev $2 | awk '/scope global dynamic/ {gsub("/","\t", $0); print $2}'
        fi
}

echo server mvuy.labs.lacnic.net
echo zone i.labs.lacnic.net
echo update delete $HOSTNAME.$ZONE
echo update add $HOSTNAME.$ZONE $TTL A $(get_ip_add 4 wlan0)
echo update add $HOSTNAME.$ZONE $TTL AAAA $(get_ip_add 6 wlan0)
echo show
echo send
