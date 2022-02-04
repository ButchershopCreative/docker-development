USE mysql;

GRANT ALL PRIVILEGES ON *.* TO 'developer'@'%';

ALTER USER 'root'@'localhost' IDENTIFIED BY 'butchershopdev';
ALTER USER 'root'@'%' IDENTIFIED BY 'butchershopdev';

FLUSH PRIVILEGES;