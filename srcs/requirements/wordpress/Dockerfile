FROM alpine:3.20

ENV PHP_VERSION=83

RUN apk update && apk upgrade && apk add --no-cache \
    php${PHP_VERSION} \
    php${PHP_VERSION}-fpm \
    php${PHP_VERSION}-mysqli \
    php${PHP_VERSION}-json \
    php${PHP_VERSION}-curl \
    php${PHP_VERSION}-dom \
    php${PHP_VERSION}-exif \
    php${PHP_VERSION}-fileinfo \
    php${PHP_VERSION}-mbstring \
    php${PHP_VERSION}-openssl \
    php${PHP_VERSION}-xml \
    php${PHP_VERSION}-zip \
    php${PHP_VERSION}-redis \
    wget \
    unzip && \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf && \
    if grep -q "^;listen.owner = nobody" /etc/php${PHP_VERSION}/php-fpm.d/www.conf; then \
        sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf; \
    fi && \
    if grep -q "^;listen.group = nobody" /etc/php${PHP_VERSION}/php-fpm.d/www.conf; then \
        sed -i "s|;listen.group = nobody|listen.group = nobody|g" /etc/php${PHP_VERSION}/php-fpm.d/www.conf; \
    fi && \
    rm -f /var/cache/apk/*

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -P /var/www && \
    mv /var/www/wp-cli.phar /usr/local/bin/wp && \
    chmod +x /usr/local/bin/wp

COPY requirements/wordpress/tools/auto_config.sh /var/www
ENTRYPOINT [ "sh", "/var/www/auto_config.sh" ]
CMD ["sh", "-c", "php-fpm${PHP_VERSION} -F"]
