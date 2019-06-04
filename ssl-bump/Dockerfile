FROM b4tman/squid

USER root
CMD ["sh", "-c", "(test -d /var/cache/squid/ssl_db || /usr/lib/squid/security_file_certgen -c -s /var/cache/squid/ssl_db -M 4MB) && /usr/sbin/squid -f ${SQUID_CONFIG_FILE} --foreground -z && exec /usr/sbin/squid -f ${SQUID_CONFIG_FILE} --foreground -YCd 1"]