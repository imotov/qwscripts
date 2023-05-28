#! /bin/zsh

SCRIPT_DIR=${0:a:h}
echo $SCRIPT_DIR
if [ ! -s "$SCRIPT_DIR/data/stackoverflow.posts.transformed-10000.json" ]; then
    curl -sk --create-dirs -O --output-dir $SCRIPT_DIR/data/ https://quickwit-datasets-public.s3.amazonaws.com/stackoverflow.posts.transformed-10000.json
fi

QW_URL=http://localhost:7280/api/v1

curl -XDELETE "$QW_URL/indexes/stackoverflow-schemaless"
curl -XPOST "$QW_URL/indexes" --header "content-type: application/yaml" --data-binary @"$SCRIPT_DIR/stackoverflow-schemaless-config.yaml"
curl -XPOST "$QW_URL/stackoverflow-schemaless/ingest?commit=force" --data-binary @"$SCRIPT_DIR/data/stackoverflow.posts.transformed-10000.json"
curl -XGET "$QW_URL/stackoverflow-schemaless/search?query=body:python"