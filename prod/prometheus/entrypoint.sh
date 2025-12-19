#!/bin/sh
set -e

echo "[INFO] Rendering prometheus.yml from template"

sed \
  -e "s|\${KAFKA_BROKER_1}|${KAFKA_BROKER_1}|g" \
  -e "s|\${KAFKA_BROKER_2}|${KAFKA_BROKER_2}|g" \
  /etc/prometheus/prometheus.yml.tmpl \
  > /etc/prometheus/prometheus.yml

# 수정된 실행 명령어
exec /bin/prometheus \
  --config.file=/etc/prometheus/prometheus.yml \
  --storage.tsdb.path=/prometheus \
  --web.enable-lifecycle \
  --web.enable-remote-write-receiver  # 이 라인을 반드시 추가하세요