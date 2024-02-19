FROM b4tman/squid

COPY run.sh /
USER root
RUN chmod 755 /run.sh

USER squid

CMD ["/run.sh"]
