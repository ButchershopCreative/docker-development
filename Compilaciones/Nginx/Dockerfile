FROM nginx:1.21.5 as build-stage
USER root

#import mime types and custom configs
COPY ./mime.types /etc/nginx/mime.types
COPY ./nginx.conf /etc/nginx/nginx.conf

#import virtualhost for differents codes {laravel-statamic-wordpress}
COPY ./virtualhost.conf /etc/nginx/conf.d/default.conf
COPY ./40-setup-folder-files-permissions.sh /tmp/
COPY ./virtualhost.sh /tmp/

#RUN chmod u+x /tmp/virtualhost.sh && ./tmp/virtualhost.sh

FROM nginx:1.21.5-alpine

COPY --from=build-stage /etc/nginx/mime.types /etc/nginx/mime.types
COPY --from=build-stage /etc/nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build-stage /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build-stage /etc/nginx/conf.d/default.conf /opt/default.conf
COPY --from=build-stage /usr/lib/nginx/modules /usr/lib/nginx/modules
COPY --from=build-stage /etc/nginx/modules /etc/nginx/modules
COPY --from=build-stage /docker-entrypoint.d /docker-entrypoint.d

RUN mkdir -p /var/cache/nginx/client_temp
RUN chown nginx:nginx /var/cache/nginx/client_temp
RUN chmod 775 /var/cache/nginx/client_temp

RUN mkdir -p /var/cache/nginx/proxy_temp
RUN chown nginx:nginx /var/cache/nginx/proxy_temp
RUN chmod 775 /var/cache/nginx/proxy_temp

RUN mkdir -p /var/cache/nginx/fastcgi_temp
RUN chown nginx:nginx /var/cache/nginx/fastcgi_temp
RUN chmod 775 /var/cache/nginx/fastcgi_temp

RUN mkdir -p /var/cache/nginx/uwsgi_temp
RUN chown nginx:nginx /var/cache/nginx/uwsgi_temp
RUN chmod 775 /var/cache/nginx/uwsgi_temp

RUN mkdir -p /var/cache/nginx/scgi_temp
RUN chown nginx:nginx /var/cache/nginx/scgi_temp
RUN chmod 775 /var/cache/nginx/scgi_temp

RUN touch /var/run/nginx.pid
RUN chown nginx:nginx /var/run/nginx.pid
RUN chmod 775 /var/run/nginx.pid

RUN touch /var/log/nginx/access.log
RUN chown nobody:nogroup /var/log/nginx/access.log
RUN chmod 777 /var/log/nginx/access.log

RUN touch /var/log/nginx/error.log
RUN chown nobody:nogroup /var/log/nginx/error.log
RUN chmod 777 /var/log/nginx/error.log

RUN mkdir -p /var/www/html/
RUN chown nginx:nginx /var/www/html/
RUN chmod 777 /var/www/html/


RUN apk add bash

COPY ./bash/ /usr/bin/
#RUN chmod +x /usr/bin/dev /usr/bin/laravel /usr/bin/statamic /usr/bin/wordpress

USER nginx
WORKDIR /var/www/html/