#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Need port (0-65535)"
    exit 1
fi

port=$1

if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 0 ] || [ "$port" -gt 65535 ]; then
    echo "'$port' is not valid port number (0-65535)"
    exit 1
fi
