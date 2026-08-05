#!/usr/bin/env bash
set -Eeuo pipefail

BOOTSTRAP_SERVER="${KAFKA_BOOTSTRAP_SERVERS:-kafka:9092}"
KAFKA_TOPICS="/opt/kafka/bin/kafka-topics.sh"

create_topic() {
  local topic="$1"
  local partitions="$2"
  local retention_ms="$3"

  echo "Ensuring topic exists: ${topic}"

  "$KAFKA_TOPICS" \
    --bootstrap-server "$BOOTSTRAP_SERVER" \
    --create \
    --if-not-exists \
    --topic "$topic" \
    --partitions "$partitions" \
    --replication-factor 1 \
    --config "min.insync.replicas=1" \
    --config "retention.ms=$retention_ms"
}

create_topic "boutique.order.events" 6 604800000
create_topic "boutique.order.events.retry" 3 86400000
create_topic "boutique.order.events.dlq" 3 2592000000

create_topic "boutique.payment.events" 6 604800000
create_topic "boutique.payment.events.retry" 3 86400000
create_topic "boutique.payment.events.dlq" 3 2592000000

create_topic "boutique.inventory.events" 12 604800000
create_topic "boutique.inventory.events.retry" 3 86400000
create_topic "boutique.inventory.events.dlq" 3 2592000000

create_topic "boutique.notification.events" 6 604800000

echo
echo "Kafka topics:"
"$KAFKA_TOPICS" --bootstrap-server "$BOOTSTRAP_SERVER" --list
