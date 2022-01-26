USE mysql;

CREATE DATABASE statamic_dev;
CREATE DATABASE statamic_stage;
CREATE DATABASE statamic_prod;

GRANT ALL PRIVILEGES ON *.* TO 'developer'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY 'butchershopdev';
ALTER USER 'root'@'%' IDENTIFIED BY 'butchershopdev';

FLUSH PRIVILEGES;