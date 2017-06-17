#!/bin/sh

CERT_PATH=/var/www/mendersoftware/cert/cert.crt
KEY_PATH=/var/www/mendersoftware/cert/private.key

waserr=0
for f in $CERT_PATH $KEY_PATH; do
    if ! test -e $f; then
        echo "required file $f not found in container"
        waserr=1
    fi
done

if [ "$waserr" = "1" ]; then
   echo "certificate or key not found, exiting"
   exit 1
fi

if [ "$DISABLE_SSL" = "true" ]; then
  rm -f /usr/local/openresty/nginx/conf.d/nginx-ssl.conf
fi

exec /usr/local/openresty/bin/openresty -g "daemon off;" $*
