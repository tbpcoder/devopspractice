#!/bin/bash

# script login goes here

echo "Task running at $(date)" >> /var/log/task.log

# Schedule it in cron:

# crontab -e
# 0 0 * * * /path/to/task.sh