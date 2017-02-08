#!/bin/sh
set -e

if [ "$1" = 'squid' ]; then
	mkdir -p /var/log/squid
	mkdir -p /var/cache/squid
	
	if [ ! "$(ls -A /var/cache/squid)" ]; then
		/usr/sbin/squid -f ${SQUID_CONFIG_FILE} -z
	fi

	exec /usr/sbin/squid -f ${SQUID_CONFIG_FILE} -NYCd 1
else
	exec "$@"
fi
