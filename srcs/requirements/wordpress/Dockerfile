FROM debian:11

ENV PHP_VERSION=7.4

RUN apt-get update && apt-get upgrade -y && apt-get install -y \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-common \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    php${PHP_VERSION}-phar \
    php${PHP_VERSION}-tokenizer \
    wget \
    unzip

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /var/www && \
    mv /var/www/wp-cli.phar /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

COPY conf/www.conf /etc/php/${PHP_VERSION}/fpm/pool.d/www.conf

RUN mkdir -p /run/php

EXPOSE 9000

COPY tools/auto_config.sh /
RUN chmod +x /auto_config.sh
ENTRYPOINT [ "sh", "/auto_config.sh" ]
CMD ["sh", "-c", "php-fpm${PHP_VERSION} -F"]
