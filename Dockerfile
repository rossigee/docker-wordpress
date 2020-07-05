FROM ubuntu:focal

ENV VERSION=5.4.2

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
        php7.4-cli \
        php7.4-fpm \
        php7.4-bcmath \
        php7.4-curl \
        php7.4-gd \
        php7.4-json \
        php7.4-ldap \
        php7.4-mbstring \
        php7.4-mysql \
        php7.4-xml \
        php7.4-xmlrpc \
        php7.4-zip \
        php-memcached \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Hack/workaround: https://bugs.launchpad.net/bugs/1872156
RUN cd /tmp && \
    curl -O http://ftp.jp.debian.org/debian/pool/main/p/php-redis/php-redis_5.2.1+4.3.0-1+b1_amd64.deb && \
    dpkg -i php-redis_5.2.1+4.3.0-1+b1_amd64.deb

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
COPY docker/php-fpm.conf /etc/php/7.4/fpm/pool.d/www.conf

# Create our document root and install WordPress into it
RUN mkdir -p /var/www/public_html && \
    curl -sSL https://wordpress.org/wordpress-$VERSION.tar.gz | \
      tar -xz --strip=1 -C /var/www/public_html
WORKDIR /var/www/public_html

