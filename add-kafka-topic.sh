#!/usr/bin/env bash

QW_URL=http://localhost:7280/api/v1

docker exec kafka-broker /bin/kafka-topics --create --topic test --partitions 3 --bootstrap-server localhost:9092

curl -XPOST $QW_URL/indexes/test/sources -H 'Content-Type: application/json' -d '{
    "version": "0.6",
    "source_id": "kafka-source",
    "source_type": "kafka",
    "num_pipelines": 3,
    "params": {
        "topic": "test",
        "client_params": {
            "bootstrap.servers": "localhost:9092"
        }
    }
}'
