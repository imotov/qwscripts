#!/usr/bin/env bash

set -e

QW_URL=http://localhost:7280/api/v1
INDEX_ID=test

curl -XDELETE $QW_URL/indexes/$INDEX_ID

curl -XPOST $QW_URL/indexes  -H "Content-Type: application/json" -d '{
    "version": "0.5",
    "index_id": "'$INDEX_ID'",
    "doc_mapping": {
        "field_mappings": [
            {
                "name": "body",
                "type": "text"
            }
        ]
    },
    "indexing_settings": {
      "commit_timeout_secs": 1
    }
}'

curl -XPOST $QW_URL/$INDEX_ID/ingest\?commit=force -H 'Content-Type: application/json' -d '
{"body":"test zero"}
{"body":"test one"}
'

curl -XPOST $QW_URL/$INDEX_ID/search -H 'Content-Type: application/json' -d '{
   "query": "body:test"
}'

