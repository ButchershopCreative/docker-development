FROM nginx:1.21.5 as build-stage
USER root

#import mime types config
COPY ./mime.types /etc/nginx/mime.types

COPY ./nginx.conf /etc/nginx/nginx.conf

COPY ./default.conf /etc/nginx/conf.d/default.conf

FROM nginx:1.21.5-alpine

COPY --from=build-stage /etc/nginx/mime.types /etc/nginx/mime.types

COPY --from=build-stage /etc/nginx/nginx.conf /etc/nginx/nginx.conf

COPY --from=build-stage /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf

COPY --from=build-stage /usr/lib/nginx/modules /usr/lib/nginx/modules

COPY --from=build-stage /etc/nginx/modules /etc/nginx/modules

RUN mkdir -p /var/www/html/
RUN chown nginx:nginx /var/www/html/
RUN chmod 775 /var/www/html/

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

USER nginx
WORKDIR /var/www/html/