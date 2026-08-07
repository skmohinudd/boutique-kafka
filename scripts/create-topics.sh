#!/usr/bin/env bash
set -Eeuo pipefail
BOOTSTRAP="${KAFKA_BOOTSTRAP_SERVERS:-kafka:9092}"
PARTITIONS="${KAFKA_TOPIC_PARTITIONS:-6}"
REPLICATION="${KAFKA_TOPIC_REPLICATION_FACTOR:-1}"
topics=(
  boutique.order.events boutique.order.events.retry boutique.order.events.dlq
  boutique.payment.events boutique.payment.events.retry boutique.payment.events.dlq
  boutique.inventory.events boutique.inventory.events.retry boutique.inventory.events.dlq
  boutique.shipping.events boutique.shipping.events.retry boutique.shipping.events.dlq
  boutique.notification.events
)
for topic in "${topics[@]}"; do
  echo "Ensuring topic exists: $topic"
  /opt/kafka/bin/kafka-topics.sh \
    --bootstrap-server "$BOOTSTRAP" \
    --create --if-not-exists \
    --topic "$topic" \
    --partitions "$PARTITIONS" \
    --replication-factor "$REPLICATION"
done
echo "Kafka topics:"
/opt/kafka/bin/kafka-topics.sh --bootstrap-server "$BOOTSTRAP" --list | sort
