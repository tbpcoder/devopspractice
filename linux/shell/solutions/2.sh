#!/bin/bash

read -p "Enter a file: " FILE

if [ -f "$FILE" ]; then
    head -n 10 "$FILE"
else
    echo "$FILE dont exist"
fi