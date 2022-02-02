FROM mariadb:x as build
USER root

ENV MYSQL_ROOT_PASSWORD butchershopdev
ENV MARIADB_USER developer
ENV MARIADB_PASSWORD developer

COPY ./scripts/ /docker-entrypoint-initdb.d/

USER mysql