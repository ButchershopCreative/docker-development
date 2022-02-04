FROM mariadb:10.7.1 as build
USER root

ENV MYSQL_ROOT_PASSWORD butchershopdev
ENV MARIADB_USER developer
ENV MARIADB_PASSWORD developer

COPY ./bash/ /usr/bin/
COPY ./scripts/ /docker-entrypoint-initdb.d/

USER mysql