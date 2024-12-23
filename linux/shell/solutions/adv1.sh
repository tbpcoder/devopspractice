#!/bin/bash

CSV_FILE="users.csv"

while IFS=',' read -r USERNAME PASSWORD; do
    if id "$USERNAME" &>/dev/null; then
        echo "User $USERNAME already exists."
    else
        useradd -m "$USERNAME"
        echo "$USERNAME:$PASSWORD" | chpasswd
        echo "User $USERNAME created."
    fi
done < "$CSV_FILE"
