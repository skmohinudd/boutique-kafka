# Boutique Kafka Local Infrastructure

This directory provides the local Kafka foundation only. Application producer
and consumer code will be integrated in the next phase.

## Architecture

- Apache Kafka in KRaft combined broker/controller mode
- No ZooKeeper
- Internal listener: `kafka:9092`
- Windows-host listener: `localhost:29092`
- Kafbat UI: `http://localhost:8088`
- Persistent named volume: `kafka_data`
- Automatic topic creation through the one-shot `kafka-init` service

## Local-only design

One combined node is appropriate for development and functional testing. It is
not a production high-availability Kafka cluster.

The AWS target will use Amazon MSK with private networking, TLS/IAM or
SASL/SCRAM authentication, multiple Availability Zones, replication factor 3,
and minimum in-sync replicas 2.
