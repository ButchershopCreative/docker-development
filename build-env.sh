#!/bin/bash -x

source .env
DATETIMECODE=`date +"%d%m%Y_%H%M%S"`
MyPATH=`pwd`
THE_LOCALHOST='localhost'
REPO=registry.digitalocean.com/butchershop/

buildNginx() {
	cd Compilaciones/Nginx/
	#changing DOCKERFILE info
	sed -i "s!nginx:x!nginx:${NGINX_VERSION}!" Dockerfile

	#building images
    docker build -t nginx-build:${NGINX_VERSION}-${DATETIMECODE}-alpine --build-arg WORKSPACE="${1}" .

	#changing DOCKERFILE info
	sed -i "s!nginx:${NGINX_VERSION}!nginx:x!" Dockerfile

	cd ${MyPATH}

	#changing docker-compose info
	sed -i "s!nginx-build:x!nginx-build:${NGINX_VERSION}-${DATETIMECODE}!" docker-compose.yaml
}

buildMariaDB() {

	#changing sql info
	cd Compilaciones/mariadb/scripts
	sed -i "s!database_dev!${1}!" star.sql

	cd ..
	
	#changing DOCKERFILE info
	sed -i "s!mariadb:x!mariadb:${MARIADB_VERSION}!" Dockerfile

	#building images
    docker build -t mariadb-build:${MARIADB_VERSION}-${DATETIMECODE} .

	#changing DOCKERFILE info
	sed -i "s!mariadb:${MARIADB_VERSION}!mariadb:x!" Dockerfile

	#changing sql info
	cd scripts
	sed -i "s!${1}!database_dev!" star.sql

	cd ${MyPATH}

	#changing docker-compose info
	sed -i "s!mariadb-build:x!mariadb-build:${MARIADB_VERSION}-${DATETIMECODE}!" docker-compose.yaml
	sed -i "s!mariadb_data!mariadb_data_${DATETIMECODE}!" docker-compose.yaml
}

setLocalhost() {
	#setting local envitonment for devs
    sudo echo "# HOST CREATED AUTOMATICALLY BY DOCKER BUILD" >> /etc/hosts
    sudo echo "127.0.1.1	${THE_LOCALHOST}" >> /etc/hosts
}

pushImage() { # ${1}

	echo "Pushing image ${1} to the repository..." 
    #
    # PUT YOUR CODE HERE TO AUTO-PUSH IMAGES TO THE D.O. IMAGES REPOSITORY
    #
}

mainmenu() {
	echo "-------------------------------"
	echo " Environments ( Mysql / Nginx )"
	echo "----------------------------------------------------------"
	echo "1.	 Laravel"
	echo "2.	 Statamic"
	echo "3.	 Wordpress"

	echo "----------------------------------------------------------"
	echo "x.	 Exit"
	echo "---------------------------------------------------------"
	echo "Select one option:"
	read entry
	case ${entry} in
	1)
		buildNginx 'laravel'
		buildMariaDB ${DB_DATABASE}
	;;
	2)
		buildNginx 'statamic'
		buildMariaDB ${DB_DATABASE}
	;;
	3)
		buildNginx 'wordpress'
		buildMariaDB ${DB_DATABASE}
	;;
	'x')
		clear
	echo "Bye..."
	;;
	esac
}

#echo ${DATETIMECODE}
mainmenu