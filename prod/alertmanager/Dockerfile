FROM prom/alertmanager:v0.27.0

USER root

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER nobody

ENTRYPOINT ["/entrypoint.sh"]