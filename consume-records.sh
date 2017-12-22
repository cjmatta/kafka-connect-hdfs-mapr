#!/bin/bash
kafka-avro-console-consumer \
    --from-beginning \
    --consumer.config ~/.ccloud/config \
    --bootstrap-server r0.sales.confluent.aws.confluent.cloud:9092 \
    --topic test_hdfs \
    --property schema.registry.url=$SCHEMA_REGISTRY \
