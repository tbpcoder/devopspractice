#!/bin/bash

if id "$1" &>/dev/null; then
    echo "User '$1' already exists."
else
    # Create the user
    sudo useradd "$1"
    if [ $? -eq 0 ]; then
        echo "User '$1' created successfully."
    else
        echo "Failed to create user '$1'."
        exit 1
    fi
fi
