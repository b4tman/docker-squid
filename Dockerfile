FROM alpine
MAINTAINER b4tman <b4tm4n@mail.ru>

ENV SQUID_CONFIG_FILE=/etc/squid/squid.conf
RUN apk add --no-cache squid

VOLUME ["/var/cache/squid"]	
	
COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["squid"]

EXPOSE 3128/tcp
