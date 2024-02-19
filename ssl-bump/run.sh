#!/bin/sh

set -x

# init ssl_db
if [ ! -d /var/cache/squid/ssl_db ]; then
	/usr/lib/squid/security_file_certgen -c -s /var/cache/squid/ssl_db -M 4MB
fi

# init cache
/usr/sbin/squid -f "${SQUID_CONFIG_FILE}" --foreground -z

# run squid
exec /usr/sbin/squid -f "${SQUID_CONFIG_FILE}" --foreground -YCd 1
