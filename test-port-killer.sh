#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 port1 [port2 ... portN]"
    exit 1
fi

openPort() {
    p=$1

    if ! [[ "$p" =~ ^[0-9]+$ ]] || [ "$p" -lt 0 ] || [ "$p" -gt 65535 ]; then
        echo ":$p is not valid (0-65535)"
        return
    fi

    nohup nc -lk -p "$port" >/dev/null 2>&1 &
    echo ":$p is open"
}

for port in "$@"; do
    openPort "$port"
done
