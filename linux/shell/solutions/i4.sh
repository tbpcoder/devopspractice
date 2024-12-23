#!/bin/bash

SRC_DIR="/path/to/source"
DEST_DIR="/path/to/backup"
BACKUP_NAME="backup_$(date +%Y%m%d_%H%M%S).tar.gz"

mkdir -p "$DEST_DIR"

tar -cvf "$DEST_DIR/$BACKUP_NAME" -C "$SRC_DIR"