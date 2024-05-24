FROM alpine:latest

RUN apk upgrade --no-cache && echo https://dl-cdn.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories &&  apk add --no-cache ca-certificates && apk add --update --no-cache s3cmd mongodb-tools

#ENTRYPOINT ["s3cmd"]
#CMD ["--help"]
