#!/bin/bash

TRESHOLD=80

USAGE=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$TRESHOLD" ]; then
    echo "Usage exceded 80%"
fi