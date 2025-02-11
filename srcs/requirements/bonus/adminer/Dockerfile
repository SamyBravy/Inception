FROM debian:11

RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y php-fpm php-mysql wget

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

RUN mkdir -p /run/php/ /var/www/

EXPOSE 9001

RUN wget https://www.adminer.org/latest.php -O /var/www/adminer.php

CMD ["php-fpm7.4", "-F"]
