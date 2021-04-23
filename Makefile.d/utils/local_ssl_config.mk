# https://github.com/MarvAmBass/docker-nginx-ssl-secure#creating-the-dh4096pem-with-openssl
local_ssl_config_issue_dh_key:
	openssl dhparam -out docker/local-ssl-config/dh.pem 512

local_ssl_config_issue_cert_and_key:
	openssl req -x509 -newkey rsa:4086 -keyout docker/local-ssl-config/key.pem -out docker/local-ssl-config/cert.pem -days 3650 -nodes -sha256
