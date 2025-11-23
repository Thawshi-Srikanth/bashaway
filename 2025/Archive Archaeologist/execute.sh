#!/bin/bash
mkdir -p "./out"
current="./src"

while true; do
    file=$(find "$current" -maxdepth 1 -type f | head -n 1)
    if [[ "$file" == *.tar.gz ]]; then
        tempdir=$(mktemp -d)
        tar -xzf "$file" -C "$tempdir"
        current="$tempdir"
    else
        mv "$file" "./out/"
        echo "Moved to ./out/"
        break
    fi
done
