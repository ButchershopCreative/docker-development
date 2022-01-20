FROM php:7.4.27-fpm as core

RUN apt update && apt upgrade -y

RUN apt install -y autoconf libcurl4-openssl-dev pkg-config libssl-dev libzip-dev htop nano curl zip cron \
                                zlib1g-dev sendmail libfreetype6-dev libjpeg62-turbo-dev libmcrypt-dev mcrypt

#RUN apt install -y supervisor

#RUN echo "sendmail_path=/usr/sbin/sendmail -t -i" >> /usr/local/etc/php/conf.d/sendmail.ini
#RUN echo "localhost localhost.localdomain" >> /etc/hosts
#RUN touch /etc/supervisord.conf
#RUN chmod 775 /etc/supervisord.conf

RUN docker-php-ext-install iconv
RUN pecl install redis-5.3.4
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install mysqli
RUN docker-php-ext-install pdo_mysql

RUN docker-php-ext-enable bcmath
RUN docker-php-ext-enable mysqli
RUN docker-php-ext-enable redis

#composer 2
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php -r "if (hash_file('sha384', 'composer-setup.php') === '906a84df04cea2aa72f40b5f787e49f22d4c2f19492ac310e8cba5b96ac8b64115ac402c8cd292b8a03482574915d1a8') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
RUN php composer-setup.php
RUN php -r "unlink('composer-setup.php');"
RUN mv composer.phar /usr/local/bin/composer

#Cleaning container
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./php.ini /usr/local/etc/php/php.ini

EXPOSE 9000
RUN chmod 775 /var/www/html/
USER www-data
WORKDIR /var/www/html/