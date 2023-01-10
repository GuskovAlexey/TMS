#!/bin/bash

##   $crontab -e
##   Dayly backup, at 12:00 pm
##   0 0 * * * /home/lespot/script/backup_files_aws_S3.sh > /dev/null 2>&1

# Number of storage copies
COPIES=3

# Basic configuration: datestamp e.g. YYYYMMDD
DATE=$(date +"%Y-%m-%d-%H:%M")

# Location of your backups 
TMP_BACKUP_DIR="/tmp/backup"
BACKUP_DIR="${TMP_BACKUP_DIR}/${DATE}"

# Create a new directory into backup directory location for this date
mkdir -p $BACKUP_DIR


# ----------------------------
# ---- BACKUP UPLOADS DIR ----
# ----------------------------
DOC_DIR="Test"
mkdir -p $BACKUP_DIR/$DOC_DIR

UPLOAD_DIR="/var/www/html"

# Gzip folder /var/www/html
echo $(date +"%b %d, %Y %H:%M:%S Begin zipping $UPLOAD_DIR")
cd 
tar czf "${BACKUP_DIR}/${DOC_DIR}.tar.gz" -P  $UPLOAD_DIR
echo $(date +"%b %d, %Y %H:%M:%S End zipping $UPLOAD_DIR")


# -------------------------------
# ---- BEGIN UPLOADING TO S3 ----
# -------------------------------
BACKUP_FILE="${TMP_BACKUP_DIR}/${DATE}.tar.gz"
tar czf $BACKUP_FILE -P $BACKUP_DIR

S3_BUCKET="s3://test-dos11/Test/"

echo $(date +"%b %d, %Y %H:%M:%S Begin uploading $BACKUP_FILE to $S3_BUCKET")
aws s3 cp $BACKUP_FILE $S3_BUCKET
echo $(date +"%b %d, %Y %H:%M:%S End uploading to S3")

# Remove backup files after uploading to S3
echo $(date +"%b %d, %Y %H:%M:%S Remove $TMP_BACKUP_DIR after uploading to S3")
rm -rf $TMP_BACKUP_DIR

# --------------------------------------
# ---- DELETE OLD BACKUP FILE IN S3 ----
# --------------------------------------
flist=($(aws s3 ls ${S3_BUCKET} | awk '{print $4}'))
len=${#flist[@]}

# Loop to delete all files and keep 3 latest files
for ((i = 0; i < $((len-$COPIES)); i++)); do
    ele0="${S3_BUCKET}${flist[$i]}"
    echo $(date +"%b %d, %Y %H:%M:%S Remove ${ele0}")
    aws s3 rm ${ele0}
done