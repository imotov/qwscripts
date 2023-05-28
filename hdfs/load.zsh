#! /bin/zsh
SCRIPT_DIR=${0:a:h}
: "${QW_CLI:=$SCRIPT_DIR/../../../quickwit-oss/quickwit/quickwit/target/debug/quickwit}"
: "${QW_URL:=http://localhost:7280/api/v1}"

curl -XDELETE "$QW_URL/indexes/hdfs-logs"
curl -XPOST "$QW_URL/indexes" --header "content-type: application/yaml" --data-binary @"$SCRIPT_DIR/hdfs_logs_index_config.yaml"
curl -sk https://quickwit-datasets-public.s3.amazonaws.com/hdfs-logs-multitenants.json.gz | gunzip | RUST_LOG=debug $QW_CLI index ingest --index hdfs-logs --force
curl -XGET "$QW_URL/hdfs-logs/search?query=severity_text:INFO"