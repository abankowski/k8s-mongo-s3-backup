FROM alpine:latest

RUN apk upgrade --no-cache && echo https://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories &&  apk add --no-cache ca-certificates && apk add --update --no-cache s3cmd mongodb-tools

COPY backup-to-s3.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/backup-to-s3.sh