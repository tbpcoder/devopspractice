#!/bin/bash

read -p "Enter a number: " NUM

for (( i=$NUM-1; i>=1; i-- )); do
    NUM=$(( NUM * i ))
done

echo "Result: $NUM"