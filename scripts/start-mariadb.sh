#!/bin/bash

# === CONFIG ===
MARIADB_BIN="/db1/myserver/mariadb/bin/mysqld"
MYCNF="/db1/myserver/mariadb/my.cnf"
LOG_FILE="/db1/myserver/mariadb/logs/startup-$(date +'%Y-%m-%d_%H-%M-%S').log"
USER="harsh"

# === Check if already running ===
if pgrep -x mysqld > /dev/null; then
  echo "[INFO] MariaDB server is already running." | tee -a "$LOG_FILE"
  exit 0
fi

# === Start MariaDB ===
echo "[INFO] Starting MariaDB server..." | tee -a "$LOG_FILE"
sudo $MARIADB_BIN --defaults-file=$MYCNF --user=$USER >> "$LOG_FILE" 2>&1 &

# === Wait briefly and confirm ===
sleep 3
if pgrep -x mysqld > /dev/null; then
  echo "[SUCCESS] MariaDB server started successfully." | tee -a "$LOG_FILE"
else
  echo "[ERROR] MariaDB failed to start. Check logs: $LOG_FILE" | tee -a "$LOG_FILE"
fi
