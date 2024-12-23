#!/bin/bash

read -p "Enter a file name: " FILE

if [ -f "$FILE" ]; then
    if [ -r "$FILE" ]; then
        echo "$FILE exists"
    else
        echo "$FILE not readable"
    fi
else
    echo "$FILE does not exist"
fi