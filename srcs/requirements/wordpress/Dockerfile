FROM alpine:3.21

ARG PHP_VERSION=8.4 \
    DB_NAME \
    DB_USER \
    DB_PASS

RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli
