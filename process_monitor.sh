#!/bin/bash

# Function to display usage instructions
usage() {
    echo "Usage: $0 -p PID -m MAX_RAM_USAGE"
    echo "  -p PID: The PID of the process to monitor"
    echo "  -m MAX_RAM_USAGE: The maximum allowed RAM usage percentage"
    exit 1
}

while getopts ":p:m:" opt; do
    case ${opt} in
        p )
            PID_TO_MONITOR=$OPTARG
            ;;
        m )
            MAX_RAM_USAGE=$OPTARG
            ;;
        \? )
            echo "Invalid option: $OPTARG" 1>&2
            usage
            ;;
        : )
            echo "Invalid option: $OPTARG requires an argument" 1>&2
            usage
            ;;
    esac
done
shift $((OPTIND -1))

if [ -z "$PID_TO_MONITOR" ] || [ -z "$MAX_RAM_USAGE" ]; then
    usage
fi

get_ram_usage() {
    local pid=$1
    local usage=$(ps -o %mem --no-headers -p "$pid")
    echo "${usage%%.*}" # Remove decimal part
}

check_storage_space() {
    local usage=$(df / | awk 'NR==2 {print $5}' | sed 's/%//g')
    echo "$usage"
}

while true; do
    ram_usage=$(get_ram_usage "$PID_TO_MONITOR")
    storage_left=$(check_storage_space)

    echo "RAM usage of PID $PID_TO_MONITOR: $ram_usage%"
    echo "Storage space left: $storage_left%"

    if [[ "$ram_usage" -gt "$MAX_RAM_USAGE" ]]; then
        echo "RAM usage exceeded $MAX_RAM_USAGE%. Killing PID $PID_TO_MONITOR..."
        kill "$PID_TO_MONITOR"
        break
    fi

    sleep 5 # Check every 5 seconds
done
