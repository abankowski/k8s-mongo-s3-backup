#!bin/sh
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

echo "Backup $DATABASE_NAME to $S3_BUCKET"
mongodump -j=1 --uri="$MONGODB_URI" -d $DATABASE_NAME -o /tmp/data

s3cmd put --include * --recursive /tmp/data/ s3://$S3_BUCKET
