#!/usr/bin/env bash

set -exuo pipefail

update-ca-certificates

rm -rfv /var/lib/squid/ssl_db

cp -fv --preserve=mode /ca/ca.crt /etc/squid-ssl/ca.crt
## pass:foobar - hardcoded in registry-proxy
openssl rsa -in /ca/ca.key -passin pass:foobar > /etc/squid-ssl/ca.key
openssl x509 -in /etc/squid-ssl/ca.crt -outform DER -out /etc/squid-ssl/ca.der

security_file_certgen -c -s /var/lib/squid/ssl_db -M 16MB
chown -R squid:squid /var/lib/squid/ssl_db

gomplate -f /etc/gomplate/squid.conf.gotmpl -o /etc/squid/squid.conf

chown root:squid /dev/stdout
chmod 0665 /dev/stdout

squid -f /etc/squid/squid.conf --foreground -z
exec gosu squid squid -f /etc/squid/squid.conf --foreground -NYCd 1
