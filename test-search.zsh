curl -XPOST "http://localhost:7280/api/v1/test/search" -H 'Content-Type: application/json' -d '{
  "query": "*",
  "max_hits": 0,
  "aggs": {
    "datetime_histogram":{
      "histogram":{
        "field": "host_ip",
        "interval": 86400000000
      }
    }
  }
}'
curl -XPOST "http://localhost:7280/api/v1/test/search" -H 'Content-Type: application/json' -d '{
  "query": "*",
  "max_hits": 0,
  "aggs": {
    "weight_histogram":{
      "histogram":{
        "field": "host_ip",
        "interval": 1
      }
    }
  }
}'
curl -XPOST "http://localhost:7280/api/v1/test/search" -H 'Content-Type: application/json' -d '{
  "query": "*",
  "max_hits": 0,
  "aggs": {
    "body_terms":{
      "terms":{
        "field": "host_ip"
      }
    }
  }
}'
curl -XPOST "http://localhost:7280/api/v1/test/search" -H 'Content-Type: application/json' -d '{
  "query": "*",
  "max_hits": 0,
  "aggs": {
    "min_weight":{
      "stats":{
        "field": "host_ip"
      }
    }
  }
}'