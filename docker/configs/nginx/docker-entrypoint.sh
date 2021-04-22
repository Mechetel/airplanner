#!/usr/bin/env bash

set -e

DEFAULT_CONFIG_PATH="/etc/nginx/conf.d/default.conf"

sed -i "s+APP_NAME+${APP_NAME}+g"       "${DEFAULT_CONFIG_PATH}"
sed -i "s+APP_PORT+${APP_PORT}+g"       "${DEFAULT_CONFIG_PATH}"
sed -i "s+APP_VHOST+${APP_VHOST}+g"     "${DEFAULT_CONFIG_PATH}"
sed -i "s+STATIC_PATH+${STATIC_PATH}+g" "${DEFAULT_CONFIG_PATH}"

exec "$@"
