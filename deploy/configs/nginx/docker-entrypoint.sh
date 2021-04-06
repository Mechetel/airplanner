#!/usr/bin/env bash

set -e

APP_NAME=${CUSTOM_APP_NAME:="server_app"}
APP_PORT=${CUSTOM_APP_PORT:="3000"}
APP_VHOST=${CUSTOM_APP_VHOST:="$(curl http://169.254.169.254/latest/meta-data/public-hostname)"}

DEFAULT_CONFIG_PATH="/etc/nginx/conf.d/default.conf"

sed -i "s+APP_NAME+${APP_NAME}+g"     "${DEFAULT_CONFIG_PATH}"
sed -i "s+APP_PORT+${APP_PORT}+g"     "${DEFAULT_CONFIG_PATH}"
sed -i "s+APP_VHOST+${APP_VHOST}+g"   "${DEFAULT_CONFIG_PATH}"
sed -i "s+STATIC_PATH+${STATIC_PATH}+g"   "${DEFAULT_CONFIG_PATH}"

exec "$@"
