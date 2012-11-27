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
IFACE=wlan0
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

nsupdate <<EOF
server mvuy.labs.lacnic.net
zone i.labs.lacnic.net
update delete $HOSTNAME.$ZONE
update add $HOSTNAME.$ZONE $TTL A $(get_ip_add 4 $IFACE)
update add $HOSTNAME.$ZONE $TTL AAAA $(get_ip_add 6 $IFACE)
show
send
EOF
