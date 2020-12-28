#!/bin/bash
set -eux

sudo chown -R www-data:www-data /var/www/html/ /home/www-data && sudo chmod 755 !$ && cd !$
git clone https://github.com/popphp/popphp-skeleton.git tmp && mv tmp/* . && rm -rf tmp/ && git reset --hard
composer install -n -q

/usr/sbin/apache2ctl -D FOREGROUND