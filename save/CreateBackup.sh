#!/bin/bash

DB_PATH="./DB/stockage.db"
BACKUP_FILE="save/backup_$(date +"%Y-%m-%d_%H-%M-%S").db"

plus_grand_id=$(sqlite3 $DB_PATH "SELECT MAX(id) FROM monitoring;")

if ls save/backup* 1> /dev/null 2>&1; then
    if [[ $(($plus_grand_id % 10)) -eq 0 ]] || [[ $1 == "manuel" ]]; then
        rm -rf save/backup*
        sqlite3 "$DB_PATH" ".backup $BACKUP_FILE"
        echo "Backup effectué"
    fi
else
    sqlite3 "$DB_PATH" ".backup $BACKUP_FILE"
    echo "Backup effectué"
fi
