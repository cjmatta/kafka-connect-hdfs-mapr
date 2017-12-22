#!/bin/bash
cat <<-EOF | kafka-avro-console-producer \
    --broker-list r0.sales.confluent.aws.confluent.cloud:9092 \
    --producer.config ~/.ccloud/config \
    --topic test_hdfs \
    --property schema.registry.url=$SCHEMA_REGISTRY \
    --property value.schema='{"type":"record","name":"myrecord","fields":[{"name":"f1","type":"string"}]}'
{"f1": "value1"}
{"f1": "value2"}
{"f1": "value3"}
EOF
