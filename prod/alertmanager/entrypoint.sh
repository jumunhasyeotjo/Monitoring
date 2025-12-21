#!/bin/sh

# 1. Critical 및 Warning 웹훅 URL 각각 치환
sed -i "s|\${SLACK_CRIT_WEBHOOK_URL}|$SLACK_CRIT_WEBHOOK_URL|g" /etc/alertmanager/alertmanager.yml.tmp
sed -i "s|\${SLACK_WARN_WEBHOOK_URL}|$SLACK_WARN_WEBHOOK_URL|g" /etc/alertmanager/alertmanager.yml.tmp

# 2. 치환된 내용을 최종 설정 파일로 복사
cp /etc/alertmanager/alertmanager.yml.tmp /etc/alertmanager/alertmanager.yml

# 3. Alertmanager 실행
exec /bin/alertmanager --config.file=/etc/alertmanager/alertmanager.yml "$@"