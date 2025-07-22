#!/bin/bash

# === CONFIG ===
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M")
BACKUP_DIR="/location/mariadb/backups"
MYSQLDUMP="/location/mariadb/bin/mysqldump"
MYCNF="/location/mariadb/my.cnf"
USER="user_name"
# === BACKUP ALL DBs ===
$MYSQLDUMP --defaults-file=$MYCNF --user=$USER --all-databases > "$BACKUP_DIR/all-databases-$TIMESTAMP.sql"

# Log
echo "[INFO] Backup completed: $BACKUP_DIR/all-databases-$TIMESTAMP.sql"
