#!/bin/bash

read -p "Enter a string: " str

REV=$(echo "$str" | rev)

if [ "$str" == "$rev" ]; then
    echo "Its a palindrome"
else 
    echo "not a Plindorme"
fi