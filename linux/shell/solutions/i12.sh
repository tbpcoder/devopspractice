#!/bin/bash

src_file="$1"
dest_path="$2"

if [ -z "$src_file" ] || [ -z "$dest_path" ]; then
    echo "Usage: $0 <source_file> <destination_path>"
    exit 1
fi

if ! cp "$src_file" "$dest_path" 2>>error.log; then
    echo "File copy operation failed. Check error.log for details."
    exit 1
else
    echo "File copied successfully."
fi
