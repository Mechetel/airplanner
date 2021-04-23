# do in remote server

# XXX: you cant use *.amazonaws.com domain
# XXX: execute before prod_ssl_config_issue_certificate `make stop_and_remove_all_containers`

# https://pyliaorachel.github.io/blog/tech/system/2017/07/14/nginx-server-ssl-setup-on-aws-ec2-linux-with-letsencrypt.html

# sudo apt-get update
# sudo apt-get install centos-release-scl
# sudo apt-get install python27
# sudo apt-get install python27-python-pip

prod_ssl_config_issue_certificate:
	sudo /usr/local/bin/certbot-auto --install-only
	sudo /usr/local/bin/certbot-auto --standalone \
		--config-dir tmp/prod-ssl-config \
		--logs-dir tmp/logs-dir \
		--work-dir tmp \
		--no-bootstrap \
		-d rails-stage-new.MYAPP.com \
		-d rails-stage-new.MYAPP.com \
		certonly
	sudo chown $$USER -R tmp/prod-ssl-config
	mkdir -p docker/prod-ssl-config
	cp tmp/prod-ssl-config/live/rails-stage-new.MYAPP.com/privkey.pem docker/prod-ssl-config/key.pem
	cp tmp/prod-ssl-config/live/rails-stage-new.MYAPP.com/fullchain.pem docker/prod-ssl-config/cert.pem

# https://github.com/MarvAmBass/docker-nginx-ssl-secure#creating-the-dh4096pem-with-openssl
prod_ssl_config_issue_dh_key:
	# nix-env -iA nixos.openssl
	rm -frd docker/prod-ssl-config/dh.pem
	openssl dhparam -out docker/prod-ssl-config/dh.pem 4096

prod_ssl_config_backup:
	cp -R docker/prod-ssl-config ~/prod-ssl-config-backup
