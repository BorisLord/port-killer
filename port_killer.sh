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

if [ "$EUID" -ne 0 ]; then
    echo "Root privileges are needed to kill ports"
    exit 1
fi

if [ -n "$(lsof -i :$port)" ]; then
    echo "Port $port is in use"
    echo "Killing process..."
    lsof -i :$port | awk 'NR!=1 {print $2}' | xargs kill -9
    echo "Done"
else
    echo "Port $port is not in use"
fi
