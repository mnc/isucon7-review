#!/bin/sh

set -e

now=`date +%Y%m%d-%H%M%S`
if [ -f /var/log/nginx/access.log ]; then
  sudo mv /var/log/nginx/access.log /var/log/nginx/access.log.$now
fi

if [ -f /etc/nginx/nginx.conf ]; then
  sudo mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.$now
fi
sudo cp nginx.conf /etc/nginx/nginx.conf
sudo systemctl restart nginx

if [ -f /var/log/mysql/slow.log ]; then
  sudo mv /var/log/mysql/slow.log /var/log/mysql/slow.log.$now
fi
mysqladmin -uisucon -pisucon flush-logs
sudo systemctl restart mysql

sudo systemctl restart isubata.ruby.service
