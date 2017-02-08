FROM armhf/alpine
MAINTAINER b4tman <b4tm4n@mail.ru>

ENV SQUID_CONFIG_FILE=/etc/squid/squid.conf

COPY docker-entrypoint.sh /
RUN apk add --no-cache squid &&\
	chmod 755 /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

VOLUME ["/var/cache/squid"]	
EXPOSE 3128/tcp

CMD ["squid"]
