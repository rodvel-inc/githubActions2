#!/bin/bash
set -e

TIMESTAMP=$(date +"%Y%m%d-%H%M%S")
BACKUP_PATH="/var/lib/postgresql/data/backup"
FILENAME="prod-backup-$TIMESTAMP.sql"

mkdir -p "$BACKUP_PATH"

pg_dump -h postgres -U postgres -F c -f "$BACKUP_PATH/$FILENAME"

echo "✅ Backup creado correctamente en: $BACKUP_PATH/$FILENAME"
