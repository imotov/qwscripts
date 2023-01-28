#! /bin/zsh

SCRIPT_DIR=${0:a:h}

if [[ -f "Cargo.toml" ]]; then
    echo "Using cargo"
    QW_CMD=(cargo r)
    DATA_PATH=$SCRIPT_DIR
else
    echo "Using docker"
    mkdir -p $SCRIPT_DIR/qwdata
    DATA_PATH=/quickwit
    QW_CMD=(docker run --rm \
        -v $SCRIPT_DIR/qwdata:/quickwit/qwdata \
        -v $SCRIPT_DIR/test-data.json:/quickwit/test-data.json \
        -v $SCRIPT_DIR/test-config.yaml:/quickwit/test-config.yaml \
        quickwit/quickwit)
fi

#$QW_CMD  index create --index-config index-config.yaml
$QW_CMD --version
$QW_CMD index delete --index test
$QW_CMD index create --index-config $DATA_PATH/test-config.yaml
$QW_CMD index ingest --index test --input-path $DATA_PATH/test-data.json
