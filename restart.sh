#!/bin/sh

set -e

now=`date +%Y%m%d-%H%M%S`
if [ -f /var/log/nginx/access.log ]; then
  sudo mv /var/log/nginx/access.log /var/log/nginx/access.log.$now
fi
sudo systemctl restart nginx

if [ -f /var/log/mysql/slow.log ]; then
  sudo mv /var/log/mysql/slow.log /var/log/mysql/slow.log.$now
fi
mysqladmin -uisucon -pisucon flush-logs
sudo systemctl restart mysql

sudo systemctl restart isubata.ruby.service
