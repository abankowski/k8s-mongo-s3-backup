#!bin/sh
set -e

if [ -z "${MONGODB_URI}" ]; then
  echo "Environment variable MONGODB_URI not present."
  echo "Valid configuration requires environment variables MONGODB_URI, DATABASE_NAME, and S3_BUCKET."
  echo "Aborting."
  exit 1
fi

if [ -z "${DATABASE_NAME}" ]; then
  echo "Environment variable DATABASE_NAME not present."
  echo "Valid configuration requires environment variables MONGODB_URI, DATABASE_NAME, and S3_BUCKET"
  echo "Aborting."
  exit 1
fi

if [ -z "${S3_BUCKET}" ]; then
  echo "Environment variable S3_BUCKET not present."
  echo "Valid configuration requires environment variables MONGODB_URI, DATABASE_NAME, and S3_BUCKET"
  echo "Aborting."
  exit 1
fi

date=$(date '+%Y-%m-%d')

filename=/tmp/data/$DATABASE_NAME-$date.archive

if [ -n "$1" ]; then
    filename=/tmp/data/$DATABASE_NAME-$date-$1.gz
fi

echo "Backup $DATABASE_NAME to $S3_BUCKET via $filename"
mongodump -j=1 --uri="$MONGODB_URI" -d $DATABASE_NAME --archive=$filename --gzip

s3cmd put $filename s3://$S3_BUCKET
