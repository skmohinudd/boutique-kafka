#!/usr/bin/env bash
set -Eeuo pipefail

TOPIC="${1:-boutique.order.events}"
KEY="${2:-test-order-001}"

EVENT='{"eventId":"00000000-0000-0000-0000-000000000001","eventType":"OrderConfirmed","eventVersion":1,"aggregateId":"test-order-001","occurredAt":"2026-08-04T00:00:00Z","data":{"orderId":"test-order-001","userId":"test-user-001","paymentId":"test-payment-001","total":39.98,"currency":"USD"}}'

printf '%s:%s\n' "$KEY" "$EVENT" | docker exec -i boutique-kafka \
  /opt/kafka/bin/kafka-console-producer.sh \
  --bootstrap-server kafka:9092 \
  --topic "$TOPIC" \
  --property parse.key=true \
  --property key.separator=:
