#!/bin/sh

curl -i -X POST http://kafka-connect-cp:18083/connectors/ \
    -H "Content-Type: application/json" \
    -d '{
      "name": "es_sink_unhappy_platinum_customers",
      "config": {
      "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
      "topics": "RATINGS_WITH_CUSTOMER_DATA",
      "key.converter": "org.apache.kafka.connect.storage.StringConverter",
      "key.ignore": "true",
      "schema.ignore": "true",
      "type.name": "type.name=kafkaconnect",
      "topic.index.map": "RATINGS_WITH_CUSTOMER_DATA:ratings_with_customer_data",
      "connection.url": "http://elasticsearch:9200",
      "transforms": "ExtractTimestamp",
      "transforms.ExtractTimestamp.type": "org.apache.kafka.connect.transforms.InsertField$Value",
      "transforms.ExtractTimestamp.timestamp.field" : "TS"
    }
}'

curl -i -X POST http://kafka-connect-cp:18083/connectors/ \
    -H "Content-Type: application/json" \
    -d '{
      "name": "es_sink_ratings_agg_by_status_1min",
      "config": {
      "connector.class": "io.confluent.connect.elasticsearch.ElasticsearchSinkConnector",
      "topics": "RATINGS_BY_CLUB_STATUS",
      "key.converter": "org.apache.kafka.connect.storage.StringConverter",
      "key.ignore": "false",
      "schema.ignore": "true",
      "type.name": "type.name=kafkaconnect",
      "topic.index.map": "RATINGS_BY_CLUB_STATUS:ratings_agg_by_status_1min",
      "connection.url": "http://elasticsearch:9200",
      "transforms": "ExtractTimestamp",
      "transforms.ExtractTimestamp.type": "org.apache.kafka.connect.transforms.InsertField$Value",
      "transforms.ExtractTimestamp.timestamp.field" : "TS"
    }
}'
