#!/usr/bin/env bash
set -Eeuo pipefail

docker exec boutique-kafka \
  /opt/kafka/bin/kafka-topics.sh \
  --bootstrap-server kafka:9092 \
  --describe
