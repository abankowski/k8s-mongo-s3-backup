#!bin/sh

mongodump -j=1 --uri="$MONGODB_URI" -d $DATABASE_NAME -o /tmp/data

s3cmd put --include * --recursive /tmp/data/ s3://$S3_BUCKET
