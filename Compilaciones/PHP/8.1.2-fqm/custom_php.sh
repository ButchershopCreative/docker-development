#!/bin/bash

case $1 in
  '1')
    #create a new php.ini
    cp -rf /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini
    rm -rf /usr/local/etc/php/php.ini-production
    cp -rf /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini /usr/local/etc/php/docker-php-ext-xdebug.ini-development
    
    #set changes to the php.ini
    sed -i 's!;html_errors = On!html_errors = On!' /usr/local/etc/php/php.ini 2>&1
    sed -i 's!post_max_size = 8M!post_max_size = 80M!' /usr/local/etc/php/php.ini 2>&1
    sed -i 's!upload_max_filesize = 2M!upload_max_filesize = 60M!' /usr/local/etc/php/php.ini 2>&1
    sed -i 's!default_socket_timeout = 60!default_socket_timeout = 360!' /usr/local/etc/php/php.ini 2>&1
    sed -i 's!;date.timezone =!date.timezone = America/Mexico_City!' /usr/local/etc/php/php.ini 2>&1
    sed -i 's!;memory_limit = 128M!memory_limit = 2048M!' /usr/local/etc/php/php.ini 2>&1
    sed -i 's!;sendmail_path =!sendmail_path=/usr/sbin/sendmail -t -i!' /usr/local/etc/php/php.ini 2>&1
    echo "End php.ini customization..."
  ;;
  '2')
    cp -rf /usr/local/etc/php/docker-php-ext-xdebug.ini-development /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
    #set changes for xdebug customization
    echo "xdebug.mode=develop,debug,coverage,gcstats" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 2>&1
    echo "xdebug.client_host=host.docker.internal" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 2>&1 
    echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 2>&1
    echo "xdebug.log=/var/www/xdebug.log" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 2>&1
    echo "xdebug.idekey=vsc" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 2>&1
    echo "xdebug.client_port=9003" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini 2>&1

    #restarting php service on container
    kill -USR2 1
    echo "End php.ini - xdebug customization..."

    #setting permissions to the entire dev environment
    cd /var/www/html/
    chown -R 1000:1000 * -R 
    echo "Permissions has been applied..."
  ;;
  'permissions')
    # in case new changes on the dev files and if get any file protection.
    #setting permissions to the entire dev environment
    cd /var/www/html/
    chown -R 1000:1000 * -R 
    echo "Permissions has been applied..."
  ;;
  *)
    # just a touch to wake you up....
    echo "Hi there....!!!"
  ;;
esac