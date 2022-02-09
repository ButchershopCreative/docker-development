FROM composer:2.2.5 as composerX

FROM node:17.4.0 as nodeX
#RUN npm install -g npm@8.4.1
RUN npm update -g

FROM mlocati/php-extension-installer:1.4.14 as php_extensioner

FROM php:8.1.2-fpm as build-stage
USER root

#INSTALLING ENVIRONMENT FUNCTION
RUN apt update && apt install -y autoconf apt-utils pkg-config libssl-dev libzip-dev libmcrypt-dev \
                            sendmail htop nano curl zip unzip cron supervisor ncdu

#INSTALLING PHP EXTENSIONS
COPY --from=php_extensioner /usr/bin/install-php-extensions /usr/bin/
RUN install-php-extensions redis-5.3.6 mysqli pdo_mysql mcrypt-1.0.4

#GET COMPOSER
COPY --from=composerX /usr/bin/composer /usr/local/bin/composer

#GET NODE
COPY --from=nodeX /usr/local/lib/node_modules /usr/local/lib/node_modules
COPY --from=nodeX /opt/yarn-v1.22.17/ /opt/yarn-v1.22.17/
COPY --from=nodeX /usr/local/bin/ /usr/local/bin/

#SETTING PHP.INI
COPY ./custom_php.sh /opt/
RUN chmod +x /opt/custom_php.sh
RUN bash /opt/custom_php.sh 1

#SET ENVIRONMENTS CHANGE OPTIONS
COPY ./bash/ /usr/local/bin/
RUN chmod +x /usr/local/bin/dev /usr/local/bin/laravel /usr/local/bin/statamic /usr/local/bin/wordpress

RUN adduser www-data root
RUN adduser www-data bin
RUN adduser www-data crontab

RUN touch /etc/supervisord.conf
RUN chown -R www-data:www-data /var/www/ /var/www/html/ /etc/supervisord.conf
RUN chmod 775 /var/www/ /var/www/html/ /etc/supervisord.conf

RUN install-php-extensions xdebug-3.1.3 gd
RUN bash /opt/custom_php.sh 2

RUN apt autoremove -y && apt autoclean -y

USER www-data
WORKDIR /var/www/html
EXPOSE 9000
