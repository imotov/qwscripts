#! /bin/zsh

SCRIPT_DIR=${0:a:h}

if [[ -f "Cargo.toml" ]]; then
    echo "Using cargo"
    QW_CMD=(cargo r)
    DATA_PATH=$SCRIPT_DIR
    CONFIG_ARG=(--config ../config/quickwit.yaml)
else
    echo "Using docker"
    mkdir -p $SCRIPT_DIR/qwdata
    DATA_PATH=/quickwit
    QW_CMD=(docker run --rm \
        -p 127.0.0.1:7280:7280 \
        -v $SCRIPT_DIR/qwdata:/quickwit/qwdata \
        -v $SCRIPT_DIR/test-data.json:/quickwit/test-data.json \
        -v $SCRIPT_DIR/test-config.yaml:/quickwit/test-config.yaml \
        quickwit/quickwit)
    CONFIG_ARG=""
fi

$QW_CMD index $CONFIG_ARG delete --index test
$QW_CMD index $CONFIG_ARG create --index-config $DATA_PATH/test-config.yaml
$QW_CMD index $CONFIG_ARG ingest --index test --input-path $DATA_PATH/test-data.json
$QW_CMD run $CONFIG_ARG --service searcher --service metastore