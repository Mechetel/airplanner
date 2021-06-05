#!/usr/bin/env bash

set -euxo pipefail

DEFAULT_CONFIG_PATH="/etc/nginx/conf.d/default.conf"

sed -i "s+NGINX_APP_NAME+${NGINX_APP_NAME}+g"       "${DEFAULT_CONFIG_PATH}"
sed -i "s+NGINX_APP_PORT+${NGINX_APP_PORT}+g"       "${DEFAULT_CONFIG_PATH}"
sed -i "s+NGINX_APP_VHOST+${NGINX_APP_VHOST}+g"     "${DEFAULT_CONFIG_PATH}"
sed -i "s+NGINX_STATIC_PATH+${NGINX_STATIC_PATH}+g" "${DEFAULT_CONFIG_PATH}"

exec "$@"
