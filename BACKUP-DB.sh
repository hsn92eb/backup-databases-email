#!/bin/bash
DB_BACKUP_PATH="/home/abcdef/domains/abcdef.com/public_html/mysql_backup"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
PASSWORD="abcdf"
# Create the backup directory if it does not exist
mkdir -p $DB_BACKUP_PATH
# Backup all databases into separate SQL files
mysqldump -u da_admin -pABCDEF --all-databases > $DB_BACKUP_PATH/all-databases-$TIMESTAMP.sql
# Zip the backup files with password
zip -r -P $PASSWORD $DB_BACKUP_PATH/all-databases-$TIMESTAMP.zip $DB_BACKUP_PATH/all-databases-$TIMESTAMP.sql
# Remove the SQL file after zipping
 rm $DB_BACKUP_PATH/all-databases-$TIMESTAMP.sql
# Send the zip file via email
echo "This is the MySQL backup file." | mutt -s "MySQL Backup" -a $DB_BACKUP_PATH/all-databases-$TIMESTAMP.zip -- info@abcdef.ir < /dev/null
