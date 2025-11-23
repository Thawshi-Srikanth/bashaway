#!/bin/bash
mkdir -p out
> out/checksums.txt

find src -type f | while read -r file; do
    checksum=$(md5sum "$file" | awk '{print $1}')
    
    rel_path="${file#src/}"

    echo "$checksum $rel_path" >> out/checksums.txt
done
