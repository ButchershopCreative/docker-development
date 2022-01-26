FROM mariadb:10.7.1 as build
USER root


COPY ./scripts/ /docker-entrypoint-initdb.d/

USER mysql