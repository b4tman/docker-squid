FROM alpine:3.5
MAINTAINER b4tman <b4tm4n@mail.ru>

ENV SQUID_VER 4.0.20
ENV SQUID_SIG_KEY B06884EDB779C89B044E64E3CD6DBF8EF3B17D3E
ENV SQUID_CONFIG_FILE /etc/squid/squid.conf
ENV TZ Europe/Moscow

RUN set -x && \
	deluser squid 2>/dev/null; delgroup squid 2>/dev/null; \
	addgroup -S squid -g 3128 && adduser -S -u 3128 -G squid -g squid -H -D -s /bin/false -h /var/cache/squid squid

RUN apk add --no-cache \
		libstdc++ \
		libcap \
		libcrypto1.0 \
		libssl1.0 \
		libltdl

RUN set -x && \
	apk add --no-cache --virtual .build-deps  \
		gcc \
		g++ \
		libc-dev \
		alpine-conf \
		tzdata \
		curl \
		gnupg \
		openssl-dev \
		perl-dev \
		autoconf \
		automake \
		make \
		pkgconfig \
		libtool \
		libcap-dev \
		linux-headers && \
	\
	mkdir -p /tmp/build && \
	cd /tmp/build && \
    curl -SsL http://www.squid-cache.org/Versions/v${SQUID_VER%.*.*}/squid-${SQUID_VER}.tar.gz -o squid-${SQUID_VER}.tar.gz && \
	curl -SsL http://www.squid-cache.org/Versions/v${SQUID_VER%.*.*}/squid-${SQUID_VER}.tar.gz.asc -o squid-${SQUID_VER}.tar.gz.asc	&& \
	\
	export GNUPGHOME="$(mktemp -d)" && \
	gpg --keyserver ha.pool.sks-keyservers.net --recv-keys ${SQUID_SIG_KEY}	&& \
	gpg --batch --verify squid-${SQUID_VER}.tar.gz.asc squid-${SQUID_VER}.tar.gz && \
	\
	tar --strip 1 -xzf squid-${SQUID_VER}.tar.gz && \
	export CFLAGS="-g0 -O2"   && \
	export CXXFLAGS="$CFLAGS" && \
	export LDFLAGS="-s" && \
	./configure \
		--build="$(uname -m)" \
		--host="$(uname -m)" \
		--prefix=/usr \
		--datadir=/usr/share/squid \
		--sysconfdir=/etc/squid \
		--libexecdir=/usr/lib/squid \
		--localstatedir=/var \
		--with-logdir=/var/log/squid \
		--disable-strict-error-checking \
		--disable-arch-native \
		--enable-removal-policies="lru,heap" \
		--enable-auth-digest \
		--enable-auth-basic="getpwnam,NCSA" \
		--enable-epoll \
		--enable-external-acl-helpers="file_userip,unix_group,wbinfo_group" \
		--enable-auth-ntlm="fake" \
		--enable-auth-negotiate="wrapper" \
		--enable-silent-rules \
		--disable-mit \
		--disable-heimdal \
		--enable-delay-pools \
		--enable-arp-acl \
		--enable-openssl \
		--enable-ssl-crtd \
		--enable-security-cert-generators="file" \
		--enable-ident-lookups \
		--enable-useragent-log \
		--enable-cache-digests \
		--enable-referer-log \
		--enable-async-io \
		--enable-truncate \
		--enable-arp-acl \
		--enable-htcp \
		--enable-carp \
		--enable-epoll \
		--enable-follow-x-forwarded-for \
		--enable-storeio="diskd rock" \
		--enable-ipv6 \
		--enable-translation \
		--disable-snmp \
		--disable-dependency-tracking \
		--with-large-files \
		--with-default-user=squid \
		--with-openssl \
		--with-pidfile=/var/run/squid/squid.pid \
	make && \
	make install && \
	install -d -o squid -g squid \
		/var/cache/squid \
		/var/log/squid \
		/var/run/squid && \
	chmod +x /usr/lib/squid/* &&\
	\
	/sbin/setup-timezone -z $TZ && \
	\
	apk del .build-deps && \
	cd / && \
	rm -rf /tmp/build "$GNUPGHOME"

RUN echo 'include /etc/squid/conf.d/*.conf' >> "$SQUID_CONFIG_FILE" && \
	install -d -m 755 -o squid -g squid /etc/squid/conf.d
COPY squid-log.conf /etc/squid/conf.d/
	
VOLUME ["/var/cache/squid"]	
EXPOSE 3128/tcp

USER squid

CMD ["sh", "-c", "/usr/sbin/squid -f ${SQUID_CONFIG_FILE} --foreground -z && exec /usr/sbin/squid -f ${SQUID_CONFIG_FILE} --foreground -YCd 1"]
