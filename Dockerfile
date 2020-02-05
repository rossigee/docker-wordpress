FROM ubuntu:focal

# Set terminal to be noninteractive
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/deb-src/# deb-src/' /etc/apt/sources.list

RUN apt-get update && \
    apt-get upgrade -y -f && \
    apt-get install -y \
        curl \
        zip \
        unzip \
        supervisor \
        ca-certificates \
        nginx \
        phpunit \
        php7.3-cli \
        php7.3-fpm \
        php7.3-bcmath \
        php7.3-curl \
        php7.3-gd \
        php7.3-json \
        php7.3-ldap \
        php7.3-mbstring \
        php7.3-mysql \
        php7.3-xml \
        php7.3-xmlrpc \
        php7.3-zip \
        php-memcached \
        php-redis \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Not sure why this doesn't get created by the distro package above
RUN mkdir /run/php

# Supervisor will manage the nginx and php processes
COPY docker/supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]

# Set up nginx to serve the site
COPY docker/nginx.conf /etc/nginx/sites-available/wordpress.conf
RUN rm -f /etc/nginx/sites-enabled/*default*
RUN ln -sf /etc/nginx/sites-available/wordpress.conf /etc/nginx/sites-enabled
EXPOSE 80

# Show nginx logs in Docker console output
RUN rm -f /var/log/nginx/* && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log

# Install PHP configurations

# Ensure PARAM* envvars are passed through PHP FPM, and it's listening on port 9000
COPY docker/php-fpm.conf /etc/php/7.3/fpm/pool.d/www.conf

# Create our document root and install WordPress into it
RUN mkdir -p /var/www/public_html && \
    curl -L --silent https://wordpress.org/wordpress-latest.tar.gz | \
      tar -xz --strip=1 -C /var/www/public_html
WORKDIR /var/www/public_html

