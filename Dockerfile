FROM alpine:latest

RUN apk -U add \
    supervisor \
    nginx \
    php7-bcmath \
    php7-ctype \
    php7-curl \
    php7-dom \
    php7-fpm \
    php7-gd \
    php7-gmp \
    php7-json \
    php7-iconv \
    php7-ldap \
    php7-mbstring \
    php7-memcached \
    php7-mysqlnd \
    php7-redis \
    php7-xml \
    php7-xmlrpc \
    php7-xdebug \
    openssh-client rsync \
    curl zip unzip

# Ensure necessary folders exist
RUN mkdir /run/nginx /run/php /var/www/public_html

# Direct nginx logs to Docker console output
RUN ln -sf /dev/stderr /var/log/nginx/error.log

#VOLUME /var/www/public_html
WORKDIR /var/www/public_html

# Yes, you'll need a seperate SSL proxy up front
EXPOSE 80

# Have supervisord manage the nginx and php-fpm processes
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Configure the nginx virtualhost
COPY docker/nginx.conf /etc/nginx/conf.d/default.conf

# Configure PHP FPM to listen on socket
COPY docker/php-fpm.conf /etc/php7/php-fpm.d/www.conf

# Create our document root and install WordPress into it
RUN curl -L --silent https://wordpress.org/wordpress-latest.tar.gz | \
      tar -xz --strip 1

# Put WP config into place
COPY docker/wp-config.php wp-config.php

