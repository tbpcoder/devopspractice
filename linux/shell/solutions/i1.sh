#!/bin/bash

DIRECTORY='.'

for FILE in "$DIRECTORY"/*.txt; do
    if [ -f "$FILE" ]; then
        LINES=$(wc -l < "$FILE" )
        echo "$FILE has $LINES."
    fi 
done