#!/bin/sh

set -x

# force remove pid
if [ -e /var/run/squid/squid.pid ]; then
	rm -f /var/run/squid/squid.pid
fi

# init cache
/usr/sbin/squid -f "${SQUID_CONFIG_FILE}" --foreground -z

# run squid
exec /usr/sbin/squid -f "${SQUID_CONFIG_FILE}" --foreground -YCd 1