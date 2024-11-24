#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Need port (0-65535)"
    exit 1
fi

port=$1

if ! [[ "$port" =~ ^[0-9]+$ ]] || [ "$port" -lt 0 ] || [ "$port" -gt 65535 ]; then
    echo "Port :$port is not valid (0-65535)"
    exit 1
fi

echo "Opening port :$port in detached mode..."
nohup nc -lk -p "$port" >/dev/null 2>&1 &

echo "Port :$port is now open"
