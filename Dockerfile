FROM alpine:latest

ADD https://php.codecasts.rocks/php-alpine.rsa.pub /etc/apk/keys/php-alpine.rsa.pub

RUN apk --update add ca-certificates wget curl && \
    echo "@php https://php.codecasts.rocks/v3.7/php-7.2" >> /etc/apk/repositories

RUN apk -U add \
    supervisor \
    nginx \
    php-bcmath@php \
    php-ctype@php \
    php-curl@php \
    php-dom@php \
    php-fpm@php \
    php-gd@php \
    php-gmp@php \
    php-json@php \
    php-iconv@php \
    php-ldap@php \
    php-mbstring@php \
    php-memcached@php \
    php-mysqli@php \
    php-mysqlnd@php \
    php-redis@php \
    php-xml@php \
    php-xmlrpc@php \
    php-xdebug@php \
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

