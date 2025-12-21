#!/bin/sh

sed "s|\${SLACK_CRIT_WEBHOOK_URL}|$SLACK_CRIT_WEBHOOK_URL|g; s|\${SLACK_WARN_WEBHOOK_URL}|$SLACK_WARN_WEBHOOK_URL|g" \
    /etc/alertmanager/alertmanager.yml.tmp > /etc/alertmanager/alertmanager.yml

exec /bin/alertmanager --config.file=/etc/alertmanager/alertmanager.yml
