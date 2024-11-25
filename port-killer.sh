#!/bin/bash

if [ "$#" -lt 1 ]; then
    echo "Usage: $0 port1 [port2 ... portN]"
    exit 1
fi

if [ "$EUID" -ne 0 ]; then
    exec sudo "$0" "$@"
fi

killPort() {
    p=$1

    if ! [[ "$p" =~ ^[0-9]+$ ]] || [ "$p" -lt 0 ] || [ "$p" -gt 65535 ]; then
        echo ":$p is not valid (0-65535)"
        return
    fi

    if [ -n "$(lsof -i :$p)" ]; then
        lsof -i :$p | awk 'NR!=1 {print $2}' | xargs kill -9
        echo ":$p Killed"
    else
        echo ":$p not in use"
    fi
}

for port in "$@"; do
    killPort "$port"
done
