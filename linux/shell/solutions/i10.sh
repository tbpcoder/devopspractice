#!/bin/bash

tail -F "$log_file" | while read -r line; do
    # Check if the line contains the word ERROR (case-insensitive)
    if echo "$line" | grep -qi "ERROR"; then
        echo "ALERT: ERROR detected!"
        echo "$line"
    fi
done