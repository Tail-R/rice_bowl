#!/bin/bash

######################################################################
## You need to install iw, networkmanager, nmcli
######################################################################

ewwPath="$HOME/.config/eww"

get_con_status() {
    if [ "$(nmcli g | awk '{print $1}' | grep connected)" == "connected" ]; then
        echo "connected" 
    else
        echo "disconnected"
    fi
}

get_ssid() {
    ssid=$(nmcli device show | grep GENERAL.CONNECTION | grep -v -E "\slo$")
    echo $(echo $ssid | awk 'NR == 1 {print $2}')
}

get_inet4() {
    echo $(nmcli --pretty | grep inet4 | awk 'NR == 1 {print $2}')
}

# Main
if [ "$1" == "-s" ]; then
    get_con_status
elif [ "$1" == "-ssid" ]; then
    get_ssid
elif [ "$1" == "--inet4" ]; then
    get_inet4
elif [ "$1" == "--toggle" ]; then
    toggle
fi













