FROM php:8.1.1-fpm as build-stage

USER root

COPY --from=mlocati/php-extension-installer /usr/bin/install-php-extensions /usr/local/bin/

RUN install-php-extensions curl redis mbstring mysqli pdo_mysql

#composer 2
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

#Cleaning container
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./php.ini /usr/local/etc/php/php.ini

RUN chmod 777 /var/www/html/

EXPOSE 9000

USER root
