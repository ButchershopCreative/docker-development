#!/bin/bash -x

#create a new php.ini
cp -rf /usr/local/etc/php/php.ini-production /usr/local/etc/php/php.ini

#set changes to the php.ini
sed -i 's!;html_errors = On!html_errors = On!' /usr/local/etc/php/php.ini
sed -i 's!post_max_size = 8M!post_max_size = 60M!' /usr/local/etc/php/php.ini
sed -i 's!upload_max_filesize = 2M!upload_max_filesize = 60M!' /usr/local/etc/php/php.ini
sed -i 's!default_socket_timeout = 60!default_socket_timeout = 360!' /usr/local/etc/php/php.ini
sed -i 's!;date.timezone =!date.timezone = America/Mexico_City!' /usr/local/etc/php/php.ini

echo "[xdebug]" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.mode=debug,develop,coverage,profile,trace,gcstats" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.log=/tmp/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.idekey=vsc" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.remote_enable=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
echo "xdebug.remote_autostart=1" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
