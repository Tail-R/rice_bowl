#! /bin/bash

get_device_name() {
    if [ "$(get_con_status)" == "connected" ]; then
        knownDeviceNumber=$(bluetoothctl devices | awk '{print $2}')

        for deviceNumber in $knownDeviceNumber; do
            if [ "$(bluetoothctl info $deviceNumber | grep Connected: | awk '{print $2}')" == "yes" ]; then
                echo $(bluetoothctl info $deviceNumber | grep Name: | awk '{print $2}') 
                return
            fi
        done
    fi
        
    echo "offline"
}

get_con_status() {
    knownDeviceNumber=$(bluetoothctl devices | awk '{print $2}')

    for deviceNumber in $knownDeviceNumber; do
        conStatus=$(bluetoothctl info $deviceNumber | grep Connected: | awk '{print $2}')
        if [ "$conStatus" == "yes" ]; then
            echo "connected"
            return
        fi
    done

    echo "disconnected"
}

toggle() {
    if [ "$(get_con_status)" == "connected" ]; then
        bluetoothctl disconnect
    else
        knownDeviceNumber=$(bluetoothctl devices | awk '{print $2}')
        
        for deviceNumber in $knownDeviceNumber; do
            bluetoothctl connect $deviceNumber 
        done    
    fi  
}


# Main
if [ "$1" == "-s" ]; then
    get_con_status
elif [ "$1" == "-d" ]; then
    get_device_name
elif [ "$1" == "-t" ]; then
    toggle
fi










