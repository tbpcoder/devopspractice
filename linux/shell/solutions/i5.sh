#!/bin/bash

read -p "Enter a service: " SERVICE

if ! systemctl is-active --quite "$service"; then
    echo "service not running"
    systemctl restart "$SERVICE"
    echo "service restarted"
else
    echo "$SERVICE is running"
fi