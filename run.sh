#!/bin/bash

#sed -i "s/ServerTokens.*/ServerTokens Prod/g" /etc/apache2/conf-available/security.conf
#sed -i "s/ServerSignature.*/ServerSignature Off/g" /etc/apache2/conf-available/security.conf

sed -i "s/StartServers.*/#StartServers 5/g" /etc/apache2/mods-available/mpm_worker.conf
sed -i "s/MaxRequestWorkers.*/#MaxRequestWorkers 400/g" /etc/apache2/mods-available/mpm_worker.conf

sed -i "s/StartServers.*/StartServers 5/g" /etc/apache2/mods-available/mpm_event.conf
sed -i "s/MaxRequestWorkers.*/MaxRequestWorkers 400/g" /etc/apache2/mods-available/mpm_event.conf

sed -i "s|DOCUMENT_ROOT|$DOCUMENT_ROOT|g" /etc/apache2/sites-available/000-default.conf
if [[ -z $FALLBACK_DOMAIN ]]; then
  sed -i "/BEGIN FALLBACK DOMAIN/,/END FALLBACK DOMAIN/d" /etc/apache2/sites-available/000-default.conf
else
  if [[ $FALLBACK_DOMAIN != http* ]]; then
    FALLBACK_DOMAIN=http://$FALLBACK_DOMAIN
  fi
  sed -i "s|FALLBACK_DOMAIN|$FALLBACK_DOMAIN|g" /etc/apache2/sites-available/000-default.conf
fi

mkdir -p /var/lock/apache2
mkdir -p /var/run/apache2/
source /etc/apache2/envvars
rm -f /var/run/apache2/apache2.pid
tail -F /var/log/apache2/* &
exec apache2 -D FOREGROUND
