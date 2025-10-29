#!/bin/sh
set -e

rm -f /run/squid.pid

mkdir -p /var/cache/squid
chown -R squid:squid /var/cache/squid
chmod -R 755 /var/cache/squid

# If auth enabled
if [ -n "$PROXY_USERNAME" ] && [ -n "$PROXY_PASSWORD" ]; then
    htpasswd -mbc /etc/squid/passwd "$PROXY_USERNAME" "$PROXY_PASSWORD"
fi

mkdir -p /var/run
chown -R squid:squid /var/run

echo "Initializing Squid cache..."
su -s /bin/sh -c "squid -z -N -f /etc/squid/squid.conf" squid

echo "Starting Squid..."
exec su -s /bin/sh -c "squid -N -f /etc/squid/squid.conf" squid
