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
USER nginx