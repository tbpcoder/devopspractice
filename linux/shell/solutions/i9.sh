#!/bin/bash

echo "System Health Report"
echo "---------------------"
echo "Uptime: $(uptime -p)"
echo "CPU Usage: $(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')%"
echo "Memory Usage: $(free -h | awk '/Mem:/ {print $3 "/" $2}')"
echo "Disk Usage: $(df -h / | awk 'NR==2 {print $5}')"
