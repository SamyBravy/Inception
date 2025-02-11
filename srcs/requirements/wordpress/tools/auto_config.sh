#!/bin/bash

set -e

WP_PATH=/var/www

cd $WP_PATH

# Download WordPress core
if [ ! -f "$WP_PATH/wp-config.php" ]; then
    wp core download --allow-root
    wp config create --dbname=${DB_NAME} --dbuser=${DB_USER} --dbpass=${DB_PASS} --dbhost=mariadb --allow-root
    wp core install --url=sdell-er.42.fr --title="Fagioli cannellini" --admin_user=${ADMIN} --admin_password=${ADMIN_PASSWORD} --admin_email=${ADMIN_EMAIL} --allow-root
fi

# Create a user if it doesn't exist
if ! wp user get ${USER} --path=$WP_PATH --allow-root > /dev/null 2>&1; then
    wp user create ${USER} ${USER_EMAIL} --role=author --user_pass=${USER_PASSWORD} --path=$WP_PATH --allow-root
fi

# Install and activate a theme if it's not already installed
if ! wp theme is-installed twentytwenty --path=$WP_PATH --allow-root; then
    wp theme install --allow-root twentytwenty --activate
fi

#install redis-plugins
if ! wp plugin is-installed redis-cache --path=$WP_PATH --allow-root; then
	wp config set WP_REDIS_HOST redis --add --allow-root
	wp config set WP_REDIS_PORT 6379 --add --allow-root
	wp config set WP_CACHE true --add --allow-root

	wp plugin install --allow-root redis-cache --activate
	wp redis enable --allow-root
	wp redis status --allow-root
	wp cache flush --allow-root
fi

wp plugin update --all --allow-root

"$@"
