#!/bin/bash
if [ ! -d src ] || [ ! -d out ]; then
    mkdir src out
fi

if [ ! -f src/data.json ]; then
cat > src/data.json <<EOF
{
    "zebra": "Hi",
    "apple": "fruit",
    "nested": {
        "zebra": 1,
        "alpha": 2,
        "beta": {
            "gamma": 3,
            "alpha": 4
        }
    },
    "array": [1, 2, 3],
    "boolean": true,
    "number": 42
}
EOF
fi

if ! command -v yq &> /dev/null; then
    sudo apt update
    sudo apt install -y yq
fi

yq -p=json -o=yaml 'sortKeys(..)' src/data.json > out/transformed.yaml
