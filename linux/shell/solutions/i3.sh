#!/bin/bash

read -p "Enter a file: " FILE

old_str="something"
new_str="something_new"

if [ -f "$FILE" ]; do
    sed -i "s/$old_str/$new_str/g" "$FILE"
fi