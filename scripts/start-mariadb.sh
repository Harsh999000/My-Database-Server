#!/bin/bash

TODAY=$(date +%F)
LOGFILE="/location/mariadb/logs/startup-$TODAY.log"

nohup /location/mariadb/bin/mysqld --defaults-file=/location/mariadb/my.cnf > "$LOGFILE" 2>&1 &
