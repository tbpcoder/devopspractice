#!/bin/bash

echo "$1 is the log file"

if [ -f "$1" ]; then
    awk '{print $1}' | sort | uniq
else
    echo "file not found"
fi