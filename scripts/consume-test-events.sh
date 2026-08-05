#!/usr/bin/env bash
set -Eeuo pipefail

TOPIC="${1:-boutique.order.events}"

docker exec -it boutique-kafka \
  /opt/kafka/bin/kafka-console-consumer.sh \
  --bootstrap-server kafka:9092 \
  --topic "$TOPIC" \
  --from-beginning \
  --property print.key=true \
  --property key.separator=" => "
