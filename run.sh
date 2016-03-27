#!/bin/bash

sed -i "s|DOCUMENT_ROOT|$DOCUMENT_ROOT|g" /etc/apache2/sites-available/000-default.conf && \
sed -i "s|FALLBACK_DOMAIN|$FALLBACK_DOMAIN|g" /etc/apache2/sites-available/000-default.conf && \

mkdir -p /var/lock/apache2
mkdir -p /var/run/apache2/
source /etc/apache2/envvars
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
