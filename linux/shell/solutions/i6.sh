#!/bin/bash

echo "Top 5 memory-consuming processes:"
ps aux --sort=-%mem | head -n 5