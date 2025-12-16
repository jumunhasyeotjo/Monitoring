#!/bin/sh

# 1. 템플릿 파일(.tmp)을 읽어 환경변수를 치환한 뒤 실제 설정 파일로 저장

# 슬래시(/)가 포함된 URL 처리를 위해 구분자를 | 로 사용
sed "s|\${SLACK_WEBHOOK_URL}|$SLACK_WEBHOOK_URL|g" /etc/alertmanager/alertmanager.yml.tmp > /etc/alertmanager/alertmanager.yml

# 2. 원래 실행하려던 Alertmanager 실행
exec /bin/alertmanager --config.file=/etc/alertmanager/alertmanager.yml