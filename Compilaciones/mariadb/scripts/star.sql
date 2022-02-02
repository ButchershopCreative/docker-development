USE mysql;

CREATE DATABASE database_dev;

GRANT ALL PRIVILEGES ON *.* TO 'developer'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY 'butchershopdev';
ALTER USER 'root'@'%' IDENTIFIED BY 'butchershopdev';

FLUSH PRIVILEGES;