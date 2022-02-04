FROM composer:2.2.5 as composerX
FROM node:17.4.0 as nodeX
FROM mlocati/php-extension-installer:1.4.14 as php_extensioner

FROM php:8.1.2-fpm as build-stage
USER root

#INSTALLING ENVIRONMENT FUNCTION
RUN apt update
RUN apt install -y autoconf libcurl4-openssl-dev pkg-config libssl-dev libzip-dev htop nano curl zip unzip cron \
                            sendmail libmcrypt-dev mcrypt apt-utils supervisor

#INSTALLING PHP EXTENSIONS
COPY --from=php_extensioner /usr/bin/install-php-extensions /usr/local/bin/
RUN install-php-extensions redis mysqli pdo_mysql xdebug
RUN docker-php-ext-enable xdebug

RUN apt autoremove -y && apt autoclean -y

#GET COMPOSER
COPY --from=composerX /usr/bin/composer /usr/bin/composer

#GET NODE
COPY --from=nodeX /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=nodeX /opt/yarn-v1.22.17/ /opt/yarn-v1.22.17/
COPY --from=nodeX /usr/local/bin/ /usr/local/bin/

#SETTING PHP.INI
COPY ./custom_php.sh /opt/
RUN sh /opt/custom_php.sh

#SET ENVIRONMENTS CHANGE OPTIONS
COPY ./bash/ /usr/bin/
RUN chmod +x /usr/bin/dev /usr/bin/laravel /usr/bin/statamic /usr/bin/wordpress

RUN adduser www-data root
RUN adduser www-data bin

RUN chown www-data:www-data /var/www/ /var/www/html/
RUN chmod 775 /var/www/html/

RUN echo "sendmail_path=/usr/sbin/sendmail -t -i" >> /usr/local/etc/php/conf.d/sendmail.ini
RUN echo "127.0.0.1 localhost" >> /etc/hosts
RUN echo "127.0.0.1 localhost.localdomain" >> /etc/hosts

RUN touch /etc/supervisord.conf
RUN chown www-data:www-data /etc/supervisord.conf
RUN chmod 775 /etc/supervisord.conf

USER www-data
WORKDIR /var/www/html
EXPOSE 9000