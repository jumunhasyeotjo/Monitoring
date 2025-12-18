FROM prom/prometheus:v2.51.1

USER root

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER nobody

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]