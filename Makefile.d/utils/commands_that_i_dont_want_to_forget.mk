# every 2 hours
add_cronjob_optimize_filemanager_uploaded_images:
	crontab -l | { cat; echo "0 */2 * * * /home/ubuntu/backend/scripts/optimize_filemanager_uploaded_images.sh > /home/ubuntu/backend/tmp/optimize_filemanager_uploaded_images.log 2>&1"; } | crontab -

# once a day
add_cronjob_sitemap:
	crontab -l | { cat; echo "02 4 * * * cd /home/ubuntu/backend && make sitemap_refresh_and_ping 2>&1"; } | crontab -

# https://gorails.com/guides/rotating-rails-production-logs-with-logrotate
setup_logrotate:
	cat << EOF > /etc/logrotate.d/MYAPP
	/var/log/MYAPP/*.log /var/log/MYAPP/*/*.log {
		daily
		missingok
		rotate 2
		compress
		delaycompress
		notifempty
		copytruncate
		olddir /var/log/MYAPP-old
	}
	EOF
