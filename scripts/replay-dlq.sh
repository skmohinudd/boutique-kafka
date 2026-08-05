#!/usr/bin/env bash
set -Eeuo pipefail

SOURCE_TOPIC="${1:-boutique.order.events.dlq}"
TARGET_TOPIC="${2:-boutique.order.events}"
GROUP_ID="dlq-replay-$(date +%s)"

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT

MSYS_NO_PATHCONV=1 docker exec boutique-kafka \
  /opt/kafka/bin/kafka-console-consumer.sh \
  --bootstrap-server kafka:9092 \
  --topic "$SOURCE_TOPIC" \
  --from-beginning \
  --group "$GROUP_ID" \
  --timeout-ms 10000 \
  > "$tmp" || true

if [[ ! -s "$tmp" ]]; then
  echo "No messages found in $SOURCE_TOPIC"
  exit 0
fi

MSYS_NO_PATHCONV=1 docker exec -i boutique-kafka \
  /opt/kafka/bin/kafka-console-producer.sh \
  --bootstrap-server kafka:9092 \
  --topic "$TARGET_TOPIC" \
  < "$tmp"

echo "Replayed messages from $SOURCE_TOPIC to $TARGET_TOPIC"
