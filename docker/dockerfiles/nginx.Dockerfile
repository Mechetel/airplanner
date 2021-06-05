FROM nginx:1.16.0

USER root

RUN apt-get update -qq && apt-get install -y curl wget

RUN wget --show-progress -q -O /usr/bin/waitforit https://github.com/maxcnunes/waitforit/releases/download/v1.3.1/waitforit-linux_amd64 && chmod +x /usr/bin/waitforit

RUN rm /usr/share/nginx/html/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

RUN touch /var/run/nginx.pid && \
    chown -R www-data:www-data /var/run/nginx.pid && \
    chown -R www-data:www-data /var/cache/nginx && \
    chown -R www-data:www-data /etc/nginx && \
    chown -R www-data:www-data /var/log

COPY prepare-config /usr/bin/prepare-config
