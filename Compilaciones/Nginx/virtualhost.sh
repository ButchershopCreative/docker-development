#!/bin/bash -x

cp -rf /tmp/virtualhost.conf /etc/nginx/conf.d/default.conf
cp -rf /tmp/40-setup-folder-files-permissions.sh /docker-entrypoint.d/40-setup-folder-files-permissions.sh

if [ $1 ];
then
    case $1 in
        wordpress)
            echo "wordpress virtualhost has been set it."
            echo "chmod 777 /var/www/html/wp-content/themes/" >> /docker-entrypoint.d/40-setup-folder-files-permissions.sh
            echo "chmod 777 /var/www/html/wp-content/themes/* -R" >> /docker-entrypoint.d/40-setup-folder-files-permissions.sh
            echo $1" virtualhost has been set it."
            ;;

        laravel | statamic )
            #sed -i '/\/var\/www\/html \/var\/www\/html\/pubic/g' /etc/nginx/conf.d/default.conf
            sed -i 's!/var/www/html!/var/www/html/public!' /etc/nginx/conf.d/default.conf
            echo "chmod 777 chmod 777 /var/www/html/storage/" >> /docker-entrypoint.d/40-setup-folder-files-permissions.sh
            echo "chmod 777 chmod 777 /var/www/html/storage/* -R" >> /docker-entrypoint.d/40-setup-folder-files-permissions.sh
            echo $1" virtualhost has been set it."
            ;;
        *)
            echo "chmod 777 /var/www/html/wp-content/themes/" >> /docker-entrypoint.d/40-setup-folder-files-permissions.sh
            echo "chmod 777 /var/www/html/wp-content/themes/* -R" >> /docker-entrypoint.d/40-setup-folder-files-permissions.sh
            echo "invalid argument has been sended. Default wordpress virtual host is working now..."
            ;;
    esac
else
	echo "Please add a valid WORKSPACE argument on the docker build option with --build-arg WORKSPACE='wordpress|laravel|statamic'..."
fi