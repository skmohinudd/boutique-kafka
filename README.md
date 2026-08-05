# boutique-kafka

Defines Kafka topics, event examples and administration scripts.

## Overview

- **Type:** Platform repository
- **Stack:** Git, Docker

## Flow

```text
Client / service → Controller → Business logic → Database / events / downstream services
```

## Configuration

```text
KAFKA_BOOTSTRAP_SERVERS
```

## CI/CD

This repository is built and deployed independently through its own GitHub Actions workflow.
